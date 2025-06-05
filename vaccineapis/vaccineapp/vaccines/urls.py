from django.contrib import admin
from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter
from django.contrib.auth import views as auth_views
router = DefaultRouter()
router.register(r'vaccines', views.VaccineViewSet, basename='vaccine')
router.register(r'categories', views.CategoryViewSet, basename='category')
router.register(r'users', views.UserViewSet, basename='users')
router.register(r'injections', views.InjectionViewSet, basename='injection')
router.register(r'campaigns', views.VaccinationCampaignViewSet,
                basename='vaccination-campaign')
router.register(r'notifications', views.NotificationViewSet,
                basename='notifications')
router.register(r'order-status', views.OrderStatusViewSet,
                basename='order-status')
router.register(r'orders', views.OrderViewSet, basename='orders')

urlpatterns = [
    path('', include(router.urls)),
    path('payment/', views.payment, name='payment'),
    path('verify-email/', views.verify_email, name='verify_email'),
]
