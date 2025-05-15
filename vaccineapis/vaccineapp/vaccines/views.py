from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from rest_framework.request import Request
from vaccines.models import Vaccine, Category, User, VaccinationCampaign, Dose, Injection, PrivateNotification, NotificationStatus, PublicNotification
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer, VaccinationCampaignSerializer, InjectionSerializer, DoseSerializer, UserRegisterSerializer, UserProfileSerializer, ChangePasswordSerializer, PrivateNotificationSerializer, PublicNotificationSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator, InjectionPaginator, UserPaginator, VaccinationCampaignPaginator, DosePaginator
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from vaccines.perms import IsStaff, UserOwner, InjectionOwner
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm
import os
# Đăng ký font Arial
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
        category = Category.objects.get(id=pk)
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
            queryset = queryset.filter(name__icontains=q, active=True)

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

        return queryset


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    pagination_class = UserPaginator
    lookup_field = 'username'

    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        elif self.action in ['retrieve', 'list', 'update', 'partial_update', 'delete',] and self.request.user.is_staff:
            return [IsStaff()]
        elif self.action in ['retrieve', 'update', 'partial_update', 'delete', 'get_injections_by_user', 'change_password', 'download_injection_certificate']:
            return [UserOwner()]
        return [IsStaff()]

    def get_serializer_class(self):
        if self.action == 'create':
            return UserRegisterSerializer
        if self.action == 'partical_update':
            return UserProfileSerializer
        return UserSerializer

    @action(detail=True, methods=['get'], url_path='injections')
    def get_injections_by_user(self, request, username=None):
        user = self.get_object()
        # self.check_object_permissions(request, user)
        injections = user.injections.filter(active=True)
        sort_by = self.request.query_params.get('sort_by')
        status_param = self.request.query_params.get('status')
        vaccine = self.request.query_params.get('vaccine')
        injection_date = self.request.query_params.get('injection_date')

        if vaccine:
            injections = injections.filter(vaccine__name__icontains=vaccine)

        if status_param:
            injections = injections.filter(status__iexact=status_param)

        if injection_date:
            injections = injections.filter(injection_time__date=injection_date)

        if sort_by == 'date_asc':
            injections = injections.order_by('injection_time', 'id')
        elif sort_by == 'date_desc':
            injections = injections.order_by('-injection_time', 'id')
        else:
            injections = injections.order_by('id')
        return Response(InjectionSerializer(injections, many=True).data, status=status.HTTP_200_OK)

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
    def download_injection_certificate(self, request, username=None, injection_id=None):
        user = self.get_object()
        try:
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


class InjectionViewSet(viewsets.ModelViewSet):
    serializer_class = InjectionSerializer
    pagination_class = InjectionPaginator
    # permission_classes = [IsStaff]

    def get_queryset(self):
        queryset = Injection.objects.filter(active=True)
        user = self.request.user
        sort_by = self.request.query_params.get('sort_by')
        status = self.request.query_params.getlist('status')
        vaccine = self.request.query_params.get('vaccine')
        injection_date = self.request.query_params.get('injection_date')

        if vaccine:
            queryset = queryset.filter(vaccine__name__icontains=vaccine)

        if status:
            status_ids = [s for s in status]
            queryset = queryset.filter(status__in=status_ids).distinct()

        if injection_date:
            queryset = queryset.filter(injection_time__date=injection_date)

        if sort_by == 'date_asc':
            queryset = queryset.order_by('injection_time', 'id')
        elif sort_by == 'date_desc':
            queryset = queryset.order_by('-injection_time', 'id')
        else:
            queryset = queryset.order_by('id')

        return queryset

    def get_permissions(self):
        if self.action == 'create':
            return [UserOwner()]
        return [IsStaff()]


class VaccinationCampaignViewSet(viewsets.ModelViewSet):
    queryset = VaccinationCampaign.objects.all()
    serializer_class = VaccinationCampaignSerializer

    def get_queryset(self):
        return VaccinationCampaign.objects.filter(active=True)

    def get_permissions(self):
        if self.request.method.__eq__('GET'):
            return [AllowAny()]
        return [IsStaff()]

    @action(detail=True, methods=['get'], url_path='injections', permission_classes=[IsStaff])
    def get_injections_by_campaign(self, request, pk):
        campaign = VaccinationCampaign.objects.get(id=pk)
        injections = campaign.injections.filter(active=True)
        return Response(InjectionSerializer(injections, many=True).data, status=status.HTTP_200_OK)


class DoseViewSet(viewsets.ModelViewSet):
    serializer_class = DoseSerializer
    pagination_class = DosePaginator

    def get_queryset(self):
        return Dose.objects.filter(active=True)


class NotificationViewSet(viewsets.ViewSet):
    def get_permissions(self):
        if self.action in ['get_unread_count', 'get_all_notifications', 'mark_notification_read', 'mark_all_notifications_read']:
            return [UserOwner()]
        return [IsStaff()]

    @action(detail=False, methods=['get'], url_path='unread-count')
    def get_unread_count(self, request):
        user = request.user
        # Sử dụng select_related và prefetch_related để giảm số lượng query
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

        # Sử dụng select_related để giảm số lượng query
        private_notifications = PrivateNotification.objects.filter(
            user=user).select_related('injection')
        private_serializer = PrivateNotificationSerializer(
            private_notifications, many=True)

        # Sử dụng select_related và prefetch_related để giảm số lượng query
        public_notifications = PublicNotification.objects.all(
        ).select_related('vaccine_campaign')
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
                # Sử dụng update thay vì get + save để giảm số lượng query
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
                # Sử dụng update_or_create để tránh race condition
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

        # Sử dụng bulk_create và bulk_update để tối ưu hiệu năng
        PrivateNotification.objects.filter(
            user=user, is_read=False).update(is_read=True)

        # Lấy tất cả thông báo public và notification status hiện tại
        public_notifications = PublicNotification.objects.all()
        existing_statuses = NotificationStatus.objects.filter(
            user=user,
            public_notification__in=public_notifications
        ).select_related('public_notification')

        # Tạo set các notification đã có status
        existing_notification_ids = {
            status.public_notification_id for status in existing_statuses}

        # Tạo danh sách các status cần cập nhật và tạo mới
        statuses_to_update = []
        statuses_to_create = []

        for status in existing_statuses:
            if not status.is_read:
                status.is_read = True
                statuses_to_update.append(status)

        for notification in public_notifications:
            if notification.id not in existing_notification_ids:
                statuses_to_create.append(
                    NotificationStatus(
                        user=user,
                        public_notification=notification,
                        is_read=True
                    )
                )

        # Thực hiện bulk update và bulk create
        if statuses_to_update:
            NotificationStatus.objects.bulk_update(
                statuses_to_update, ['is_read'])
        if statuses_to_create:
            NotificationStatus.objects.bulk_create(statuses_to_create)

        return Response({'message': 'Đã đánh dấu tất cả thông báo đã đọc'},
                        status=status.HTTP_200_OK)
