from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from rest_framework.request import Request
from vaccines.models import Vaccine, Category, User, VaccinationCampaign, Dose, Injection, Notification
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer, VaccinationCampaignSerializer, InjectionSerializer, DoseSerializer, UserRegisterSerializer, UserProfileSerializer, ChangePasswordSerializer, NotificationSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator, InjectionPaginator, UserPaginator, VaccinationCampaignPaginator, DosePaginator
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from vaccines.perms import IsStaff, UserOwner, InjectionOwner
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from rest_framework import permissions


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
        elif self.action in ['retrieve', 'update', 'partial_update', 'delete', 'get_injections_by_user', 'change_password']:
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

    # Tạo file PDF
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="certificate_{user.username}_injection_{injection.id}.pdf"'

        p = canvas.Canvas(response)
        p.setFont("Helvetica-Bold", 16)
        p.drawString(100, 800, f"Giấy chứng nhận tiêm chủng")
        p.setFont("Helvetica", 12)
        p.drawString(100, 780, f"Họ tên: {user.get_full_name()}")
        p.drawString(100, 760, f"Username: {user.username}")
        p.drawString(100, 740, f"Số điện thoại: {user.phone or ''}")

        y = 700
        p.setFont("Helvetica-Bold", 12)
        p.drawString(100, y, "Thông tin mũi tiêm:")
        y -= 20
        p.setFont("Helvetica", 11)
        p.drawString(110, y, f"Vaccine: {injection.vaccine.name}")
        y -= 18
        p.drawString(110, y, f"Số mũi: {injection.number}")
        y -= 18
        p.drawString(110, y, f"Ngày tiêm: {injection.injection_time.strftime('%d/%m/%Y')}")
        y -= 18
        p.drawString(110, y, f"Trạng thái: {injection.get_status_display()}")
        y -= 18
        if injection.note:
            p.drawString(110, y, f"Ghi chú: {injection.note}")

        p.showPage()
        p.save()
        return response

class InjectionViewSet(viewsets.ModelViewSet):
    serializer_class = InjectionSerializer
    pagination_class = InjectionPaginator
    permission_classes = [IsStaff]

    def get_queryset(self):
        queryset = Injection.objects.filter(active=True)
        user = self.request.user
        sort_by = self.request.query_params.get('sort_by')
        status = self.request.query_params.get('status')
        vaccine = self.request.query_params.get('vaccine')
        injection_date = self.request.query_params.get('injection_date')

        if vaccine:
            queryset = queryset.filter(vaccine__name__icontains=vaccine)

        if status:
            queryset = queryset.filter(status__iexact=status)

        if injection_date:
            queryset = queryset.filter(injection_time__date=injection_date)

        if sort_by == 'date_asc':
            queryset = queryset.order_by('injection_time', 'id')
        elif sort_by == 'date_desc':
            queryset = queryset.order_by('-injection_time', 'id')
        else:
            queryset = queryset.order_by('id')

        return queryset



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
