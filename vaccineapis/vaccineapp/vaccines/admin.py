from django.contrib import admin
from vaccines.models import Category, Vaccine

class VaccineAppAdmin(admin.AdminSite):
    site_header = 'HỆ THỐNG QUẢN LÝ TRUNG TÂM VACCINE'
    index_title = 'Vaccine App'

admin_site = VaccineAppAdmin()

class BaseAdmin(admin.ModelAdmin):
    list_per_page = 30

class CategoryAdmin(BaseAdmin):
    list_display = ('name', 'image')
    search_fields = ('name',)
    list_filter = ('name',)


class VaccineAdmin(BaseAdmin):
    list_display = ('name', 'disease', 'price')
    search_fields = ('name', 'disease', 'price')
    list_filter = ('name', 'disease', 'price')
    filter_horizontal = ('cates',)


admin_site.register(Category, CategoryAdmin)
admin_site.register(Vaccine, VaccineAdmin)
# admin.site.register()
