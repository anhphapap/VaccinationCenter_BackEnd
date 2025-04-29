from django.contrib import admin
from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'vaccines', views.VaccineViewSet, basename='vaccine')
router.register(r'categories', views.CategoryViewSet, basename='category')
router.register(r'user', views.UserViewSet, basename='user')
router.register(r'injections', views.InjectionViewSet, basename='injection')
router.register(r'campaigns', views.VaccinationCampaignViewSet, basename='vaccination-campaign')

urlpatterns = [
    path('', include(router.urls)),
]
