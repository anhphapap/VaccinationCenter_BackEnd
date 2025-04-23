from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from vaccines.models import Vaccine, Category, User
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = CategoryPaginator

    #tim kiem theo ten
    def get_queryset(self):
        queryset = self.queryset
        q = self.request.query_params.get('q')
        if q:
            queryset = queryset.filter(name__icontains=q)
        return queryset

    #lay danh sach vaccine theo category
    @action(detail=True, methods=['get'], url_path='vaccines')
    def get_vaccines_by_category(self, request, pk):
        category = Category.objects.get(id=pk)
        vaccines = category.vaccines.filter(active=True)
        return Response(VaccineSerializer(vaccines, many=True).data, status=status.HTTP_200_OK)


class VaccineViewSet(viewsets.ViewSet, generics.RetrieveAPIView, generics.ListAPIView):
    queryset = Vaccine.objects.filter(active=True)
    serializer_class = VaccineDetailSerializer
    pagination_class = VaccinePaginator
    
    #tim kiem theo ten
    def get_queryset(self):
        queryset = self.queryset
        q = self.request.query_params.get('q')
        if q:
            queryset = queryset.filter(name__icontains=q)
        return queryset


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer

    #lay thong tin user hien tai
    @action(detail=False, methods=['get'], url_path='current-user', permission_classes=[IsAuthenticated])
    def get_current_user(self, request):
        return Response(UserSerializer(request.user).data, status=status.HTTP_200_OK)
