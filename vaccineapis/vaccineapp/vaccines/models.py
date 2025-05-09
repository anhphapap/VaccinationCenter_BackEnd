from django.db import models
from ckeditor.fields import RichTextField
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from enum import Enum


class User(AbstractUser):
    avatar = models.CharField(
        max_length=255)
    birth_date = models.DateField(null=True, blank=True)
    gender = models.BooleanField(default=True, null=True, blank=True)
    phone = models.CharField(
        unique=True, max_length=255, null=True, blank=True)
    address = models.CharField(max_length=255, null=True, blank=True)
    is_completed_profile = models.BooleanField(default=False)

    class Meta:
        verbose_name = 'Người dùng'
        verbose_name_plural = 'Người dùng'


class BaseModel(models.Model):
    active = models.BooleanField(default=True)
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class Category(models.Model):
    name = models.CharField(max_length=255)
    image = models.CharField(max_length=255)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Danh mục'
        verbose_name_plural = 'Danh mục'


class Vaccine(BaseModel):
    id = models.CharField(max_length=255, primary_key=True)
    name = models.CharField(max_length=255)
    description = RichTextField()
    injection = RichTextField()
    patient = models.TextField()
    effects = RichTextField()
    disease = models.CharField(max_length=255)
    country = models.CharField(max_length=255, default="")
    image = models.CharField(max_length=255)
    price = models.FloatField()
    cates = models.ManyToManyField(
        Category, blank=True, related_name='vaccines')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Vacxin'
        verbose_name_plural = 'Vacxin'


class Dose(BaseModel):
    vaccine = models.ForeignKey(
        Vaccine, on_delete=models.CASCADE, related_name='doses')
    number = models.IntegerField()
    days_after_previous = models.IntegerField()
    note = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Vaccine {self.vaccine.name} - Mũi {self.number}"


class InjectionStatus(Enum):
    NOT_VACCINATED = 'NOT_VACCINATED'
    VACCINATED = 'VACCINATED'
    MISSED = 'MISSED'

    @classmethod
    def choices(cls):
        return [(status.value, status.name) for status in cls]

    @classmethod
    def get_display_name(cls, status_value):
        display_names = {
            'NOT_VACCINATED': 'Chưa tiêm',
            'VACCINATED': 'Đã tiêm',
            'MISSED': 'Bỏ lỡ'
        }
        return display_names.get(status_value, status_value)


class Injection(BaseModel):
    vaccine = models.ForeignKey(
        Vaccine, on_delete=models.CASCADE, related_name='injections', null=True, blank=True)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='injections')
    vaccination_campaign = models.ForeignKey(
        'VaccinationCampaign', on_delete=models.CASCADE, related_name='injections')
    injection_time = models.DateTimeField()
    number = models.IntegerField(null=True, blank=True, default=1)
    status = models.CharField(
        max_length=20,
        choices=InjectionStatus.choices(),
        default=InjectionStatus.NOT_VACCINATED.value
    )
    note = models.TextField(null=True)

    def __str__(self):
        return f"{self.vaccine.name} - {self.user.username} - {self.injection_time}"

    def get_status_display(self):
        return InjectionStatus.get_display_name(self.status)

    class Meta:
        verbose_name = 'Lịch tiêm'
        verbose_name_plural = 'Lịch tiêm'
        indexes = [
            models.Index(fields=['user', 'vaccination_campaign', 'active']),
            models.Index(fields=['injection_time']),
        ]


class VaccinationCampaign(BaseModel):
    name = models.CharField(max_length=255)
    description = RichTextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    vaccine = models.ForeignKey(
        Vaccine, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Đợt tiêm cộng đồng'
        verbose_name_plural = 'Đợt tiêm cộng đồng'


class Notification(models.Model):
    title = models.CharField(max_length=255)
    message = models.TextField()
    notification_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True



class PrivateNotification(Notification):
    injection = models.ForeignKey(
        Injection, on_delete=models.CASCADE, related_name='notifications', null=True, blank=True)
    is_read = models.BooleanField(default=False)

    def __str__(self):
        return f"Notification for {self.user.username} - {self.title}"

    class Meta:
        verbose_name = 'Thông báo'
        verbose_name_plural = 'Thông báo'
        ordering = ['-notification_date']


class PublicNotification(Notification):
    vaccine_campaign = models.ForeignKey(VaccinationCampaign, on_delete=models.CASCADE, related_name='public_notification')


class NotificationStatus(models.Model):
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='notification_status')
    public_notification = models.ForeignKey(
        PublicNotification, on_delete=models.CASCADE, related_name='notification_status')
    is_read = models.BooleanField(default=False)

    class Meta: 
        unique_together = ('user', 'public_notification')
        indexes = [
            models.Index(fields=['user', 'is_read']),
        ]
    
