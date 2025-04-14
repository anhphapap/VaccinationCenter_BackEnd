from django.contrib import admin

from vaccines.models import Category, Vaccine

admin.site.register(Category)
admin.site.register(Vaccine)
