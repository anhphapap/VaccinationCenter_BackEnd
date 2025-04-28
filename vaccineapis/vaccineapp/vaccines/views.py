from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from rest_framework.request import Request
from vaccines.models import Vaccine, Category, User, VaccinationCampaign, Dose, Injection
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer, VaccinationCampaignSerializer, InjectionSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator, InjectionPaginator, UserPaginator, VaccinationCampaignPaginator
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from vaccines.perms import IsStaff, UserOwner

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
        if q:
            queryset = queryset.filter(name__icontains=q)
        return queryset


class UserViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView, generics.CreateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    pagination_class = UserPaginator
    lookup_field = 'username'

    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        if self.action == 'retrieve':
            return [UserOwner()]
        return [IsAuthenticated()]

    def update(self, request, *args, **kwargs):
        if request.method == 'PATCH':
            return super().update(request, *args, **kwargs)
        return Response({'error': 'Method not allowed'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


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



class VaccinationCampaignViewSet(viewsets.ModelViewSet ):
    queryset = VaccinationCampaign.objects.all()
    serializer_class = VaccinationCampaignSerializer
    permission_classes = [IsStaff]
    def get_queryset(self):
        return VaccinationCampaign.objects.filter(active=True)
