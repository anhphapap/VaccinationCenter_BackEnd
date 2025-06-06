from django.views.decorators.csrf import csrf_exempt
from vaccines.models import Order
from .vnpay import vnpay
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.conf import settings
from datetime import datetime
import requests
import random
import urllib.parse
import urllib
import json
import hmac
import hashlib
from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from vaccines.models import Vaccine, Category, User, VaccinationCampaign, Dose, Injection, PrivateNotification, NotificationStatus, PublicNotification, Order, OrderDetail
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer, VaccinationCampaignSerializer, InjectionSerializer, DoseSerializer, UserRegisterSerializer, UserProfileSerializer, ChangePasswordSerializer, PrivateNotificationSerializer, PublicNotificationSerializer, OrderStatusSerializer, OrderSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator, InjectionPaginator, UserPaginator, VaccinationCampaignPaginator, DosePaginator, OrderPaginator
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from vaccines.perms import IsStaff, UserOwner, InjectionOwner, NotificationOwner, OrderOwner
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm
from django.db.models import Q
import os
from rest_framework.decorators import api_view
from django.utils import timezone
from django.core.mail import send_mail
from django.utils.crypto import get_random_string
from datetime import timedelta
# dang ky font Arial
FONT_PATH = os.path.join(os.path.dirname(__file__), 'fonts', 'arial.ttf')
pdfmetrics.registerFont(TTFont('Arial', FONT_PATH))


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = CategoryPaginator

    # tim kiem theo ten
    def get_queryset(self):
        queryset = self.queryset
        q = self.request.query_params.get('q')
        if q:
            queryset = queryset.filter(name__icontains=q)
        return queryset

    # lay danh sach vaccine theo category
    @action(detail=True, methods=['get'], url_path='vaccines')
    def get_vaccines_by_category(self, request, pk):
        category = Category.objects.prefetch_related('vaccines').get(id=pk)
        vaccines = category.vaccines.filter(active=True)
        return Response(VaccineSerializer(vaccines, many=True).data, status=status.HTTP_200_OK)



class VaccineViewSet(viewsets.ViewSet, generics.RetrieveAPIView, generics.ListAPIView):
    queryset = Vaccine.objects.filter(active=True)
    pagination_class = VaccinePaginator

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return VaccineDetailSerializer
        return VaccineSerializer

    # tim kiem theo ten
    def get_queryset(self):
        queryset = self.queryset
        q = self.request.query_params.get('q')
        sort_by = self.request.query_params.get('sort_by')
        cates = self.request.query_params.getlist('cate')
        min_price = self.request.query_params.get('min_price')
        max_price = self.request.query_params.get('max_price')
        # tim kiem theo ten
        if q:
            queryset = queryset.filter(name__icontains=q)

        # loc theo danh muc
        if cates:
            cate_ids = [int(cate) for cate in cates]
            queryset = queryset.filter(cates__id__in=cate_ids).distinct()
        # loc theo gia
        if min_price:
            queryset = queryset.filter(price__gte=float(min_price))
        if max_price:
            queryset = queryset.filter(price__lte=float(max_price))

        # sap xep theo gia
        if sort_by == 'price_asc':
            queryset = queryset.order_by('price', 'id')
        elif sort_by == 'price_desc':
            queryset = queryset.order_by('-price', 'id')
        else:
            queryset = queryset.order_by('id')

        return queryset.prefetch_related('doses', 'cates')


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    pagination_class = UserPaginator
    http_method_names = ['get', 'post', 'patch']

    def get_queryset(self):
        queryset = User.objects.filter(is_active=True)
        name = self.request.query_params.get('name')

        if name:
            queryset = queryset.filter(
                Q(first_name__icontains=name) | Q(last_name__icontains=name))
        return queryset

    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        elif self.action == 'download_injection_certificate':
            if self.request.user.is_staff:
                return [IsStaff()]
            return [UserOwner()]
        elif self.action in ['list'] or self.request.user.is_staff:
            return [IsStaff()]
        elif self.action in ['retrieve', 'update', 'partial_update', 'delete', 'get_injections_by_user', 'change_password', 'get_current_user']:
            return [UserOwner()]
        return [IsStaff()]

    def get_serializer_class(self):
        if self.action == 'create':
            return UserRegisterSerializer
        if self.action == 'partial_update':
            return UserProfileSerializer
        return UserSerializer

    def send_verification_email(self, user):
        # Tạo token xác thực
        token = get_random_string(length=32)
        user.email_verification_token = token
        user.email_verification_token_created_at = timezone.now()
        user.save()

        # Tạo link xác thực
        verification_url = f"{settings.FRONTEND_URL}/verify-email?token={token}"
        print(verification_url)

        # Nội dung email
        subject = 'Xác nhận địa chỉ email của bạn'
        message = f'''
        Xin chào {user.get_full_name() or user.username},

        Cảm ơn bạn đã đăng ký tài khoản. Vui lòng nhấp vào đường link sau để xác nhận địa chỉ email của bạn:

        {verification_url}

        Link này sẽ hết hạn sau 5 phút.

        Nếu bạn không yêu cầu xác nhận email này, vui lòng bỏ qua email này.

        Trân trọng,
        Đội ngũ Vaccination Center
        '''

        # Gửi email
        try:
            send_mail(
                subject,
                message,
                settings.DEFAULT_FROM_EMAIL,
                [user.email],
                fail_silently=False,
            )
            print("Test email sent successfully!")
        except Exception as e:
            print(f"Failed to send test email: {e}")

    @action(detail=True, methods=['post'], url_path='resend-verification-email')
    def resend_verification_email(self, request, pk=None):
        user = self.get_object()
        if user.email_verified:
            return Response({'message': 'Email đã được xác thực trước đó'}, status=status.HTTP_400_BAD_REQUEST)

        # Kiểm tra nếu token cũ vẫn còn hiệu lực (chưa quá 5 phút)
        if user.email_verification_token_created_at and user.email_verification_token_created_at > timezone.now() - timedelta(minutes=5):
            return Response({'message': 'Vui lòng đợi 5 phút trước khi yêu cầu gửi lại email xác thực'}, status=status.HTTP_400_BAD_REQUEST)

        self.send_verification_email(user)
        return Response({'message': 'Đã gửi lại email xác thực'}, status=status.HTTP_200_OK)

    def partial_update(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(
            instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        if 'email' in request.data:

            instance.email_verified = False
            self.send_verification_email(instance)
        return Response(serializer.data)

    @action(detail=True, methods=['get'], url_path='injections')
    def get_injections_by_user(self, request, pk=None):
        user = self.get_object()
        # self.check_object_permissions(request, user)
        injections = user.injections.filter(active=True)
        sort_by = self.request.query_params.get('sort_by')
        status_param = self.request.query_params.getlist('status')
        vaccine = self.request.query_params.get('vaccine')
        injection_date = self.request.query_params.get('injection_date')

        if vaccine:
            injections = injections.filter(vaccine__name__icontains=vaccine)

        if status_param:
            injections = injections.filter(status__in=status_param)

        if injection_date:
            injections = injections.filter(injection_time__date=injection_date)

        if sort_by == 'date_asc':
            injections = injections.order_by('injection_time', 'id')
        elif sort_by == 'date_desc':
            injections = injections.order_by('-injection_time', 'id')
        else:
            injections = injections.order_by('id')
        return Response(InjectionSerializer(injections, many=True).data, status=status.HTTP_200_OK)

    @action(detail=False, methods=['get'], url_path='current-user')
    def get_current_user(self, request):
        user = request.user
        return Response(UserSerializer(user).data, status=status.HTTP_200_OK)

    @action(detail=True, methods=['patch'], url_path='change-password')
    def change_password(self, request, username):
        user = request.user
        serializer = ChangePasswordSerializer(data=request.data)

        if serializer.is_valid():
            old_password = serializer.validated_data['old_password']
            new_password = serializer.validated_data['new_password']

            if not user.check_password(old_password):
                return Response({'error': 'Mật khẩu cũ không đúng'},
                                status=status.HTTP_400_BAD_REQUEST)

            try:
                user.set_password(new_password)
                user.save()
                return Response({'message': 'Đổi mật khẩu thành công'},
                                status=status.HTTP_200_OK)
            except Exception as e:
                return Response({'error': str(e)},
                                status=status.HTTP_400_BAD_REQUEST)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=True, methods=['get'], url_path='injection-certificate/(?P<injection_id>[^/.]+)')
    def download_injection_certificate(self, request, pk=None, injection_id=None):
        user = self.get_object()
        try:
            if request.user.is_staff:
                injection = Injection.objects.get(id=injection_id)
            else:
                injection = Injection.objects.get(id=injection_id, user=user)
        except Injection.DoesNotExist:
            return Response({'error': 'Injection không tồn tại hoặc không thuộc về user này'}, status=status.HTTP_404_NOT_FOUND)

        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="certificate_{user.username}_injection_{injection.id}.pdf"'
        p = canvas.Canvas(response, pagesize=A4)
        width, height = A4
        margin = 20 * mm

        p.setFont("Arial", 12)
        p.drawCentredString(width/2, height - margin,
                            "CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM")
        p.setFont("Arial", 11)
        p.drawCentredString(width/2, height - margin - 18,
                            "Độc lập - Tự do - Hạnh phúc")
        p.line(width/2 - 60, height - margin - 21,
               width/2 + 60, height - margin - 21)

        p.setFont("Arial", 16)
        p.drawCentredString(width/2, height - margin - 45,
                            "GIẤY XÁC NHẬN ĐÃ TIÊM VẮC XIN")

        y = height - margin - 75
        p.setFont("Arial", 12)
        p.drawString(margin, y, f"Họ và tên: {user.get_full_name()}")
        y -= 18
        p.drawString(
            margin, y, f"Sinh ngày: {user.birth_date.strftime('%d/%m/%Y') if user.birth_date else ''}    Giới tính: {'Nam' if user.gender else 'Nữ'}")
        y -= 18
        p.drawString(margin, y, f"Số điện thoại: {user.phone or ''}")
        y -= 18
        p.drawString(margin, y, f"Địa chỉ: {user.address or ''}")

        y -= 30
        p.setFont("Arial", 12)
        p.drawString(margin, y, "Thông tin mũi tiêm:")
        y -= 18
        p.setFont("Arial", 11)
        p.drawString(margin + 20, y, f"Vaccine: {injection.vaccine.name}")
        y -= 16
        p.drawString(margin + 20, y, f"Số mũi: {injection.number}")
        y -= 16
        p.drawString(
            margin + 20, y, f"Thời gian tiêm: {injection.injection_time.strftime('%H:%M, ngày %d/%m/%Y')}")
        y -= 16
        p.drawString(margin + 20, y,
                     f"Trạng thái: {injection.get_status_display()}")
        y -= 16
        if injection.note:
            p.drawString(margin + 20, y, f"Ghi chú: {injection.note}")

        y -= 40
        p.setFont("Arial", 12)
        p.drawRightString(width - margin, y, "Đơn vị tiêm chủng")
        y -= 16
        p.setFont("Arial", 10)
        p.drawRightString(width - margin, y, "(Ký, đóng dấu)")

        p.showPage()
        p.save()
        return response


def verify_email(request):
    token = request.GET.get('token')
    user = User.objects.filter(email_verification_token=token).first()
    if user and not user.email_verified:
        # Kiểm tra hạn token (24h)
        if user.email_verification_token_created_at and user.email_verification_token_created_at < timezone.now() - timedelta(minutes=5):
            return render(request, 'verification/email_verification_failed.html', {'reason': 'Link xác thực đã hết hạn'})
        user.email_verified = True
        user.email_verification_token = None
        user.email_verification_token_created_at = None
        user.save()
        return render(request, 'verification/email_verification_success.html', {'reason': 'Email đã được xác thực thành công'})
    else:
        return render(request, 'verification/email_verification_failed.html', {'reason': 'Token không hợp lệ hoặc đã xác thực'})


class InjectionViewSet(viewsets.ModelViewSet):
    serializer_class = InjectionSerializer
    pagination_class = InjectionPaginator
    http_method_names = ['get', 'post', 'patch']

    def get_queryset(self):
        queryset = Injection.objects.filter(active=True)
        user = self.request.user
        sort_by = self.request.query_params.get('sort_by')
        status = self.request.query_params.getlist('status')
        vaccine = self.request.query_params.get('vaccine')
        injection_date = self.request.query_params.get('injection_date')
        full_name = self.request.query_params.get('name')

        if user:
            queryset = queryset.filter()
        if vaccine:
            queryset = queryset.filter(vaccine__name__icontains=vaccine)

        if status:
            queryset = queryset.filter(status__in=status)

        if injection_date:
            queryset = queryset.filter(injection_time__date=injection_date)

        if full_name:
            queryset = queryset.filter(
                Q(user__first_name__icontains=full_name) |
                Q(user__last_name__icontains=full_name)
            )

        if sort_by == 'date_asc':
            queryset = queryset.order_by('injection_time', 'id')
        elif sort_by == 'date_desc':
            queryset = queryset.order_by('-injection_time', 'id')
        else:
            queryset = queryset.order_by('id')

        return queryset

    def get_permissions(self):
        if self.action == 'create':
            return [OrderOwner()]
        return [IsStaff()]


class VaccinationCampaignViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView):
    queryset = VaccinationCampaign.objects.all()
    serializer_class = VaccinationCampaignSerializer

    def get_permissions(self):
        if self.request.method.__eq__('GET'):
            return [AllowAny()]
        return [IsStaff()]


class DoseViewSet(viewsets.ModelViewSet):
    serializer_class = DoseSerializer
    pagination_class = DosePaginator

    def get_queryset(self):
        return Dose.objects.filter(active=True)


class NotificationViewSet(viewsets.ViewSet):
    def get_permissions(self):
        if self.action in ['get_unread_count', 'get_all_notifications', 'mark_notification_read', 'mark_all_notifications_read']:
            return [NotificationOwner()]
        return [IsAuthenticated()]

    def get_serializer_class(self):
        return PrivateNotificationSerializer

    @action(detail=False, methods=['get'], url_path='unread-count')
    def get_unread_count(self, request):
        user = request.user
        private_unread = PrivateNotification.objects.filter(
            user=user, is_read=False).count()
        public_unread = NotificationStatus.objects.filter(
            user=user, is_read=False).count()

        return Response(
            {
                'total_unread': private_unread + public_unread
            }, status=status.HTTP_200_OK)

    @action(detail=False, methods=['get'], url_path='all')
    def get_all_notifications(self, request):
        user = request.user

        private_notifications = PrivateNotification.objects.filter(
            user=user)
        private_serializer = PrivateNotificationSerializer(
            private_notifications, many=True)

        public_notifications = PublicNotification.objects.all()
        public_serializer = PublicNotificationSerializer(
            public_notifications,
            many=True,
            context={'request': request}
        )

        all_notifications = []
        for notification in private_serializer.data:
            notification['type'] = 'private'
            all_notifications.append(notification)

        for notification in public_serializer.data:
            notification['type'] = 'public'
            all_notifications.append(notification)

        all_notifications.sort(
            key=lambda x: x['notification_date'], reverse=True)

        return Response(all_notifications, status=status.HTTP_200_OK)

    @action(detail=True, methods=['patch'], url_path='mark-read')
    def mark_notification_read(self, request, pk=None):
        notification_type = request.data.get('type')
        user = request.user

        if notification_type == 'private':
            try:
                updated = PrivateNotification.objects.filter(
                    id=pk, user=user, is_read=False).update(is_read=True)
                if updated:
                    return Response({'message': 'Đã đánh dấu thông báo private đã đọc'},
                                    status=status.HTTP_200_OK)
                return Response({'error': 'Không tìm thấy thông báo private hoặc đã được đánh dấu đọc'},
                                status=status.HTTP_404_NOT_FOUND)
            except Exception:
                return Response({'error': 'Không tìm thấy thông báo private'},
                                status=status.HTTP_404_NOT_FOUND)

        elif notification_type == 'public':
            try:
                notification = PublicNotification.objects.get(id=pk)
                notification_status, created = NotificationStatus.objects.update_or_create(
                    user=user,
                    public_notification=notification,
                    defaults={'is_read': True}
                )
                return Response({'message': 'Đã đánh dấu thông báo public đã đọc'},
                                status=status.HTTP_200_OK)
            except PublicNotification.DoesNotExist:
                return Response({'error': 'Không tìm thấy thông báo public'},
                                status=status.HTTP_404_NOT_FOUND)

        return Response({'error': 'Loại thông báo không hợp lệ'},
                        status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='mark-all-read')
    def mark_all_notifications_read(self, request):
        user = request.user

        # Đánh dấu tất cả thông báo private đã đọc
        PrivateNotification.objects.filter(
            user=user, is_read=False).update(is_read=True)

        # Đánh dấu tất cả thông báo public đã đọc
        NotificationStatus.objects.filter(
            user=user, is_read=False).update(is_read=True)

        return Response({'message': 'Đã đánh dấu tất cả thông báo đã đọc'},
                        status=status.HTTP_200_OK)


def hmacsha512(key, data):
    byteKey = key.encode('utf-8')
    byteData = data.encode('utf-8')
    return hmac.new(byteKey, byteData, hashlib.sha512).hexdigest()


@api_view(['POST', 'PATCH'])
def payment(request):
    if request.method == 'PATCH':
        id = request.data.get('id')
        new_order_id = request.data.get('order_id')
        try:
            order = Order.objects.get(id=id)
            order.order_id = new_order_id
            order.save()
            # Tạo lại link thanh toán mới
            order_type = request.data.get('order_type', order.order_desc)
            amount = request.data.get('amount', order.amount)
            order_desc = request.data.get('order_desc', order.order_desc)
            bank_code = request.data.get('bank_code', None)
            language = request.data.get('language', None)
            ipaddr = get_client_ip(request)
            vnp = vnpay()
            vnp.requestData['vnp_Version'] = '2.1.0'
            vnp.requestData['vnp_Command'] = 'pay'
            vnp.requestData['vnp_TmnCode'] = settings.VNPAY_TMN_CODE
            vnp.requestData['vnp_Amount'] = int(amount) * 100
            vnp.requestData['vnp_CurrCode'] = 'VND'
            vnp.requestData['vnp_TxnRef'] = new_order_id
            vnp.requestData['vnp_OrderInfo'] = order_desc
            vnp.requestData['vnp_OrderType'] = order_type
            if language and language != '':
                vnp.requestData['vnp_Locale'] = language
            else:
                vnp.requestData['vnp_Locale'] = 'vn'
            if bank_code and bank_code != "":
                vnp.requestData['vnp_BankCode'] = bank_code
            vnp.requestData['vnp_CreateDate'] = datetime.now().strftime(
                '%Y%m%d%H%M%S')
            vnp.requestData['vnp_IpAddr'] = ipaddr
            vnp.requestData['vnp_ReturnUrl'] = settings.VNPAY_RETURN_URL
            vnpay_payment_url = vnp.get_payment_url(
                settings.VNPAY_PAYMENT_URL, settings.VNPAY_HASH_SECRET_KEY)
            return JsonResponse({'RspCode': '00', 'Message': 'Order updated successfully', 'payment_url': vnpay_payment_url})
        except Order.DoesNotExist:
            return JsonResponse({'RspCode': '01', 'Message': 'Order not found'}, status=404)

    if request.method == 'POST':
        order_type = request.data.get('order_type')
        order_id = request.data.get('order_id')
        amount = request.data.get('amount')
        order_desc = request.data.get('order_desc')
        bank_code = request.data.get('bank_code')
        language = request.data.get('language')
        ipaddr = get_client_ip(request)
        order_details = request.data.get('order_detail', [])

        vnp = vnpay()
        vnp.requestData['vnp_Version'] = '2.1.0'
        vnp.requestData['vnp_Command'] = 'pay'
        vnp.requestData['vnp_TmnCode'] = settings.VNPAY_TMN_CODE
        vnp.requestData['vnp_Amount'] = int(amount) * 100
        vnp.requestData['vnp_CurrCode'] = 'VND'
        vnp.requestData['vnp_TxnRef'] = order_id
        vnp.requestData['vnp_OrderInfo'] = order_desc
        vnp.requestData['vnp_OrderType'] = order_type
        if language and language != '':
            vnp.requestData['vnp_Locale'] = language
        else:
            vnp.requestData['vnp_Locale'] = 'vn'
        if bank_code and bank_code != "":
            vnp.requestData['vnp_BankCode'] = bank_code

        vnp.requestData['vnp_CreateDate'] = datetime.now().strftime(
            '%Y%m%d%H%M%S')
        vnp.requestData['vnp_IpAddr'] = ipaddr
        vnp.requestData['vnp_ReturnUrl'] = settings.VNPAY_RETURN_URL
        vnpay_payment_url = vnp.get_payment_url(
            settings.VNPAY_PAYMENT_URL, settings.VNPAY_HASH_SECRET_KEY)

        order = Order.objects.create(
            order_id=order_id,
            amount=amount,
            order_desc=order_desc,
            user=request.user,
            vnp_ResponseCode="01"
        )

        for detail in order_details:
            OrderDetail.objects.create(
                order=order,
                vaccine_id=detail.get('vaccine_id'),
                unit_price=detail.get('unit_price'),
            )

        return JsonResponse({'payment_url': vnpay_payment_url})

    return JsonResponse({'error': 'Invalid request method'}, status=405)


@csrf_exempt
@api_view(['GET'])
def payment_ipn(request):
    inputData = request.GET
    if inputData:
        vnp = vnpay()
        vnp.responseData = inputData.dict()

        order_id = inputData.get('vnp_TxnRef')
        amount = int(inputData.get('vnp_Amount', 0)) / 100
        order_desc = inputData.get('vnp_OrderInfo')
        vnp_TransactionNo = inputData.get('vnp_TransactionNo')
        vnp_ResponseCode = inputData.get('vnp_ResponseCode')
        vnp_TmnCode = inputData.get('vnp_TmnCode')
        vnp_PayDate = inputData.get('vnp_PayDate')
        vnp_BankCode = inputData.get('vnp_BankCode')
        vnp_CardType = inputData.get('vnp_CardType')

        if vnp.validate_response(settings.VNPAY_HASH_SECRET_KEY):
            if not Order.objects.filter(order_id=order_id).exists():
                if vnp_ResponseCode == '00':
                    Order.objects.create(
                        order_id=order_id,
                        amount=amount,
                        order_desc=order_desc,
                        vnp_TransactionNo=vnp_TransactionNo,
                        vnp_ResponseCode=vnp_ResponseCode,
                        vnp_TmnCode=vnp_TmnCode,
                        vnp_PayDate=datetime.strptime(
                            vnp_PayDate, '%Y%m%d%H%M%S'),
                        vnp_BankCode=vnp_BankCode,
                        vnp_CardType=vnp_CardType,
                        user=None  # Nếu IPN không có user thì để None hoặc mapping nếu có info
                    )
                    return JsonResponse({'RspCode': '00', 'Message': 'Confirm Success'})
                else:
                    return JsonResponse({'RspCode': '00', 'Message': 'Payment Failed'})
            else:
                return JsonResponse({'RspCode': '02', 'Message': 'Order Already Updated'})
        else:
            return JsonResponse({'RspCode': '97', 'Message': 'Invalid Signature'})
    else:
        return JsonResponse({'RspCode': '99', 'Message': 'Invalid request'})


@api_view(['GET'])
def payment_return(request):
    inputData = request.GET
    print("hello")
    if inputData:
        vnp = vnpay()
        vnp.responseData = inputData.dict()
        order_id = inputData.get('vnp_TxnRef')
        amount = int(inputData.get('vnp_Amount', 0)) / 100
        order_desc = inputData.get('vnp_OrderInfo')
        vnp_TransactionNo = inputData.get('vnp_TransactionNo')
        vnp_ResponseCode = inputData.get('vnp_ResponseCode')
        vnp_TmnCode = inputData.get('vnp_TmnCode')
        vnp_PayDate = inputData.get('vnp_PayDate')
        vnp_BankCode = inputData.get('vnp_BankCode')
        vnp_CardType = inputData.get('vnp_CardType')
        vnp_TransactionStatus = inputData.get('vnp_TransactionStatus')
        vnp_BankTranNo = inputData.get('vnp_BankTranNo')
        order = Order.objects.filter(order_id=order_id)
        if order.exists():
            order.update(
                vnp_TransactionNo=vnp_TransactionNo,
                vnp_ResponseCode=vnp_ResponseCode,
                vnp_TmnCode=vnp_TmnCode,
                vnp_PayDate=datetime.strptime(
                    vnp_PayDate, '%Y%m%d%H%M%S'),
                vnp_BankCode=vnp_BankCode,
                vnp_CardType=vnp_CardType,
            )
            return JsonResponse({'RspCode': '00', 'Message': 'Payment Success'})
        else:
            return JsonResponse({'RspCode': '02', 'Message': 'Order Already Updated'})
    else:
        return JsonResponse({'RspCode': '99', 'Message': 'Invalid request'})


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


n = random.randint(10**11, 10**12 - 1)
n_str = str(n)
while len(n_str) < 12:
    n_str = '0' + n_str


def query(request):
    if request.method == 'GET':
        return render(request, "payment/query.html", {"title": "Kiểm tra kết quả giao dịch"})

    url = settings.VNPAY_API_URL
    secret_key = settings.VNPAY_HASH_SECRET_KEY
    vnp_TmnCode = settings.VNPAY_TMN_CODE
    vnp_Version = '2.1.0'

    vnp_RequestId = n_str
    vnp_Command = 'querydr'
    vnp_TxnRef = request.POST['order_id']
    vnp_OrderInfo = 'kiem tra gd'
    vnp_TransactionDate = request.POST['trans_date']
    vnp_CreateDate = datetime.now().strftime('%Y%m%d%H%M%S')
    vnp_IpAddr = get_client_ip(request)

    hash_data = "|".join([
        vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
        vnp_TxnRef, vnp_TransactionDate, vnp_CreateDate,
        vnp_IpAddr, vnp_OrderInfo
    ])

    secure_hash = hmac.new(secret_key.encode(),
                           hash_data.encode(), hashlib.sha512).hexdigest()

    data = {
        "vnp_RequestId": vnp_RequestId,
        "vnp_TmnCode": vnp_TmnCode,
        "vnp_Command": vnp_Command,
        "vnp_TxnRef": vnp_TxnRef,
        "vnp_OrderInfo": vnp_OrderInfo,
        "vnp_TransactionDate": vnp_TransactionDate,
        "vnp_CreateDate": vnp_CreateDate,
        "vnp_IpAddr": vnp_IpAddr,
        "vnp_Version": vnp_Version,
        "vnp_SecureHash": secure_hash
    }

    headers = {"Content-Type": "application/json"}

    response = requests.post(url, headers=headers, data=json.dumps(data))

    if response.status_code == 200:
        response_json = json.loads(response.text)
    else:
        response_json = {
            "error": f"Request failed with status code: {response.status_code}"}

    return render(request, "payment/query.html", {"title": "Kiểm tra kết quả giao dịch", "response_json": response_json})


def refund(request):
    if request.method == 'GET':
        return render(request, "payment/refund.html", {"title": "Hoàn tiền giao dịch"})

    url = settings.VNPAY_API_URL
    secret_key = settings.VNPAY_HASH_SECRET_KEY
    vnp_TmnCode = settings.VNPAY_TMN_CODE
    vnp_RequestId = n_str
    vnp_Version = '2.1.0'
    vnp_Command = 'refund'
    vnp_TransactionType = request.POST['TransactionType']
    vnp_TxnRef = request.POST['order_id']
    vnp_Amount = request.POST['amount']
    vnp_OrderInfo = request.POST['order_desc']
    vnp_TransactionNo = '0'
    vnp_TransactionDate = request.POST['trans_date']
    vnp_CreateDate = datetime.now().strftime('%Y%m%d%H%M%S')
    vnp_CreateBy = 'user01'
    vnp_IpAddr = get_client_ip(request)

    hash_data = "|".join([
        vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode, vnp_TransactionType, vnp_TxnRef,
        vnp_Amount, vnp_TransactionNo, vnp_TransactionDate, vnp_CreateBy, vnp_CreateDate,
        vnp_IpAddr, vnp_OrderInfo
    ])

    secure_hash = hmac.new(secret_key.encode(),
                           hash_data.encode(), hashlib.sha512).hexdigest()

    data = {
        "vnp_RequestId": vnp_RequestId,
        "vnp_TmnCode": vnp_TmnCode,
        "vnp_Command": vnp_Command,
        "vnp_TxnRef": vnp_TxnRef,
        "vnp_Amount": vnp_Amount,
        "vnp_OrderInfo": vnp_OrderInfo,
        "vnp_TransactionDate": vnp_TransactionDate,
        "vnp_CreateDate": vnp_CreateDate,
        "vnp_IpAddr": vnp_IpAddr,
        "vnp_TransactionType": vnp_TransactionType,
        "vnp_TransactionNo": vnp_TransactionNo,
        "vnp_CreateBy": vnp_CreateBy,
        "vnp_Version": vnp_Version,
        "vnp_SecureHash": secure_hash
    }

    headers = {"Content-Type": "application/json"}

    response = requests.post(url, headers=headers, data=json.dumps(data))

    if response.status_code == 200:
        response_json = json.loads(response.text)
    else:
        response_json = {
            "error": f"Request failed with status code: {response.status_code}"}

    return render(request, "payment/refund.html", {"title": "Kết quả hoàn tiền giao dịch", "response_json": response_json})


class OrderStatusViewSet(viewsets.ViewSet, generics.RetrieveAPIView):
    serializer_class = OrderStatusSerializer
    queryset = Order.objects.all()
    lookup_field = 'order_id'
    permission_classes = [IsAuthenticated]


class OrderViewSet(viewsets.ViewSet, generics.ListAPIView):
    serializer_class = OrderSerializer
    permission_classes = [OrderOwner]
    pagination_class = OrderPaginator

    def get_queryset(self):
        queryset = Order.objects.filter(user=self.request.user)
        status = self.request.query_params.get('status')
        if status == 'paid':
            queryset = queryset.filter(vnp_ResponseCode='00')
        elif status == 'pending':
            queryset = queryset.filter(
                Q(vnp_ResponseCode='01') | Q(vnp_ResponseCode='24'))

        queryset = queryset.order_by('-created_date')

        return queryset
