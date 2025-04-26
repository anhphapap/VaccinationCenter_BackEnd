from django.http import HttpResponse
from rest_framework import viewsets, generics, status
from rest_framework.decorators import action
from rest_framework.request import Request
from vaccines.models import Vaccine, Category, User, VaccinationCampaign, Dose, Injection
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer, UserSerializer, VaccinationCampaignSerializer, InjectionSerializer
from vaccines.paginators import CategoryPaginator, VaccinePaginator
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny


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


class UserViewSet(viewsets.ViewSet, generics.RetrieveUpdateAPIView, generics.CreateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'username'

    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        return [IsAuthenticated()]


# class VaccinationCampaignViewSet(viewsets.ViewSet, generics.ListAPIView):
#     queryset = VaccinationCampaign.objects.all()
#     serializer_class = VaccinationCampaignSerializer

    # @action(detail=True, methods=['post'], url_path='vaccination-campaigns', permission_classes=[IsAuthenticated])

class InjectionViewSet(viewsets.ViewSet, generics.ListAPIView):
    serializer_class = InjectionSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Injection.objects.filter(user=self.request.user)

    @action(detail=True, methods=['post'], url_path='injections', permission_classes=[IsAuthenticated])
    def create_injection(self, request):
       vaccine_id = request.data.get('vaccine_id')
       if not vaccine_id:
           return Response({'error': 'Vaccine ID is required'}, status=status.HTTP_400_BAD_REQUEST)
       vaccine = Vaccine.objects.get(id=vaccine_id)
       if not vaccine:
           return Response({'error': 'Vaccine not found'}, status=status.HTTP_404_NOT_FOUND)
       injection = Injection.objects.create(user=request.user, vaccine=vaccine)
       return Response(InjectionSerializer(injection).data, status=status.HTTP_201_CREATED)

