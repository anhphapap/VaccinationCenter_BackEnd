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

    # phan quyen
    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        if self.action in ['list'] or self.action in ['update', 'partical_update']:
            return [IsStaff()]
        return [UserOwner()]

    def get_serializer_class(self):
        if self.action == 'create':
            return UserRegisterSerializer
        if self.action == 'partical_update':
            return UserProfileSerializer
        return UserSerializer

    @action(detail=True, methods=['get'], url_path='injections')
    def get_injections_by_user(self, request, username=None):
        user = self.get_object()  # Điều này sẽ trigger has_object_permission
        # Bắt buộc phải gọi dòng này!
        self.check_object_permissions(request, user)
        injections = user.injections.filter(active=True)
        return Response(InjectionSerializer(injections, many=True).data, status=status.HTTP_200_OK)

    # @action(detail=True, methods=['patch'], url_path='change-password', permission_classes=[UserOwner])
    # def change_password(self, request, username):
    #     user = request.user
    #     serializer = ChangePasswordSerializer(data=request.data)
    #     old_password = request.data.get('old_password')
    #     new_password = request.data.get('new_password')

    #     if not old_password or not new_password:
    #         return Response({'error': 'Vui lòng cung cấp mật khẩu cũ và mật khẩu mới'},
    #                         status=status.HTTP_400_BAD_REQUEST)

    #     if not user.check_password(old_password):
    #         return Response({'error': 'Mật khẩu cũ không đúng'},
    #                         status=status.HTTP_400_BAD_REQUEST)

    #     try:
    #         user.set_password(new_password)
    #         user.save()
    #         return Response({'message': 'Đổi mật khẩu thành công'},
    #                         status=status.HTTP_200_OK)
    #     except Exception as e:
    #         return Response({'error': str(e)},
    #                         status=status.HTTP_400_BAD_REQUEST)
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

    # @action(detail=True, methods=['post'], url_path='campaigns')
    # def create_campaign(self, request, pk):
    #     user = User.objects.get(id=pk)
    #     campaign = VaccinationCampaign.objects.create(
    #         user=user,
    #         name=request.data['name'],
    #         description=request.data['description'],
    #         start_date=request.data['start_date'],
    #         end_date=request.data['end_date'],
    #     )
    #     return Response(VaccinationCampaignSerializer(campaign).data, status=status.HTTP_200_OK)


class InjectionViewSet(viewsets.ModelViewSet):
    serializer_class = InjectionSerializer
    pagination_class = InjectionPaginator

    def get_queryset(self):
        user = self.request.user
        if user.is_staff:
            return Injection.objects.all()
        return Injection.objects.filter(user=self.request.user)

    def get_permissions(self):
        if self.action == 'put' or self.action == 'patch' or self.action == 'delete':
            return [IsStaff()]
        return [InjectionOwner()]

    # def generate_certificate(self, injection):
    #     buffer = BytesIO()
    #     p = canvas.Canvas(buffer, pagesize=A4)

    #     # Set font
    #     p.setFont("Helvetica-Bold", 16)

    #     # Title
    #     p.drawCentredString(300, 800, "GIẤY CHỨNG NHẬN TIÊM CHỦNG")

    #     # User information
    #     p.setFont("Helvetica", 12)
    #     p.drawString(100, 700, f"Họ và tên: {injection.user.get_full_name()}")
    #     p.drawString(
    #         100, 670, f"Ngày sinh: {injection.user.birth_date.strftime('%d/%m/%Y') if injection.user.birth_date else 'N/A'}")
    #     p.drawString(100, 640, f"Địa chỉ: {injection.user.address or 'N/A'}")

    #     # Vaccine information
    #     p.drawString(100, 600, f"Tên vaccine: {injection.vaccine.name}")
    #     p.drawString(100, 570, f"Liều tiêm: {injection.number}")
    #     p.drawString(
    #         100, 540, f"Ngày tiêm: {injection.injection_time.strftime('%d/%m/%Y')}")
    #     p.drawString(
    #         100, 510, f"Đợt tiêm: {injection.vaccination_campaign.name}")

    #     # Footer
    #     p.setFont("Helvetica", 10)
    #     p.drawString(
    #         100, 100, f"Ngày cấp: {timezone.now().strftime('%d/%m/%Y')}")
    #     p.drawString(400, 100, "Cơ sở tiêm chủng")

    #     p.showPage()
    #     p.save()

    #     buffer.seek(0)
    #     return buffer

    # @action(detail=True, methods=['get'], url_path='download-certificate')
    # def download_certificate(self, request, pk=None):
    #     injection = self.get_object()

    #     # Generate PDF
    #     buffer = self.generate_certificate(injection)

    #     # Create response
    #     response = HttpResponse(buffer, content_type='application/pdf')
    #     response[
    #         'Content-Disposition'] = f'attachment; filename="certificate_{injection.user.username}_{injection.injection_time.strftime("%Y%m%d")}.pdf"'

    #     return response


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
