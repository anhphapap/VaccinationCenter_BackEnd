from django.db import models
from ckeditor.fields import RichTextField
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    pass

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
    outline = RichTextField()
    effects = RichTextField()
    disease = models.CharField(max_length=255)
    image = models.CharField(max_length=255)
    price = models.FloatField()
    cates = models.ManyToManyField(Category, blank=True, related_name='vaccines')

    def __str__(self):
        return self.name




