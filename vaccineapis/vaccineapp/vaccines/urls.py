from django.contrib import admin
from django.urls import path, include
from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'vaccines', views.VaccineViewSet, basename='vaccine')
router.register(r'categories', views.CategoryViewSet, basename='category')
router.register(r'users', views.UserViewSet, basename='users')
router.register(r'injections', views.InjectionViewSet, basename='injection')
router.register(r'campaigns', views.VaccinationCampaignViewSet,
                basename='vaccination-campaign')
router.register(r'notifications', views.NotificationViewSet,
                basename='notifications')


urlpatterns = [
    path('', include(router.urls)),
    path('', views.index, name='index'),
    path('payment/', views.payment, name='payment'),
    path('payment_ipn/', views.payment_ipn, name='payment_ipn'),
    path('payment_return/', views.payment_return, name='payment_return'),
    path('query/', views.query, name='query'),
    path('refund/', views.refund, name='refund'),
]
