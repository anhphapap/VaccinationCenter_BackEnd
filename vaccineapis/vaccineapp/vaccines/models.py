from django.db import models
from ckeditor.fields import RichTextField
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    avatar = models.CharField(max_length=255, default='/static/images/avatar.png')
    birth_date = models.DateField()
    gender = models.BooleanField(default=True)
    phone = models.CharField(max_length=255)


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


class Dose(models.Model):
    vaccine = models.ForeignKey(Vaccine, on_delete=models.CASCADE)
    number = models.IntegerField()
    days_after_previous = models.IntegerField()
    note = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Vaccine {self.vaccine.name} - Mũi {self.number}"


class Injection(models.Model):
    dose = models.ForeignKey(Dose, on_delete=models.PROTECT)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    vaccination_campaign = models.ForeignKey(
        'VaccinationCampaign', on_delete=models.CASCADE)
    injection_time = models.DateTimeField()

    def __str__(self):
        return f"{self.dose.vaccine.name} - {self.user.username} - {self.injection_time}"


class VaccinationCampaign(models.Model):
    name = models.CharField(max_length=255)
    description = RichTextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    # created_by = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.name
