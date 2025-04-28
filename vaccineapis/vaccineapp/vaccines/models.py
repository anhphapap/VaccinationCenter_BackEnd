from django.db import models
from ckeditor.fields import RichTextField
from django.contrib.auth.models import AbstractUser
from django.utils import timezone


class User(AbstractUser):
    avatar = models.CharField(
        max_length=255, default='/static/images/avatar.png')
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
    origin = models.TextField()
    injection = RichTextField()
    recommend = RichTextField()
    manual = RichTextField()
    preserve = RichTextField()
    patient = models.TextField()
    effects = RichTextField()
    disease = models.CharField(max_length=255)
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



class Injection(BaseModel):
    dose = models.ForeignKey(Dose, on_delete=models.PROTECT)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    vaccination_campaign = models.ForeignKey(
        'VaccinationCampaign', on_delete=models.CASCADE)
    injection_time = models.DateTimeField()

    def __str__(self):
        return f"{self.dose.vaccine.name} - {self.user.username} - {self.injection_time}"

    class Meta:
        verbose_name = 'Lịch tiêm'
        verbose_name_plural = 'Lịch tiêm'



class VaccinationCampaign(BaseModel):
    name = models.CharField(max_length=255)
    description = RichTextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    vaccine = models.ForeignKey(Vaccine, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name
    
    class Meta:
        verbose_name = 'Đợt tiêm cộng đồng'
        verbose_name_plural = 'Đợt tiêm cộng đồng'

