from django.http import HttpResponse
from rest_framework import viewsets, generics
from rest_framework.decorators import action
from vaccines.models import Vaccine, Category
from vaccines.serializers import VaccineSerializer, CategorySerializer, VaccineDetailSerializer 
from vaccines.paginators import CategoryPaginator, VaccinePaginator
from rest_framework.response import Response


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = CategoryPaginator

    @action(detail=True, methods=['get'], url_path='vaccines')
    def get_vaccines_by_category(self, request, pk):
        category = Category.objects.get(id=pk)
        vaccines = category.vaccines.filter(active=True)
        serializer = VaccineSerializer(vaccines, many=True)
        return Response(serializer.data)

class VaccineViewSet(viewsets.ViewSet, generics.RetrieveAPIView, generics.ListAPIView):
    queryset = Vaccine.objects.filter(active=True)
    serializer_class = VaccineDetailSerializer
    pagination_class = VaccinePaginator
