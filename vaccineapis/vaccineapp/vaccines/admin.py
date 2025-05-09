from django.contrib import admin
from vaccines.models import Category, Vaccine, Injection, VaccinationCampaign, User


class VaccineAppAdmin(admin.AdminSite):
    site_header = ' TRUNG TÂM VACCINE PV'
    index_title = 'Quản lý'


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


class InjectionAdmin(BaseAdmin):
    list_display = ('vaccine', 'user',
                    'vaccination_campaign', 'injection_time')
    search_fields = ('vaccine', 'user',
                     'vaccination_campaign', 'injection_time')
    list_filter = ('vaccine', 'user', 'vaccination_campaign', 'injection_time')


class VaccinationCampaignAdmin(BaseAdmin):
    list_display = ('name', 'start_date', 'end_date')
    search_fields = ('name', 'start_date', 'end_date')
    list_filter = ('name', 'start_date', 'end_date')


class UserAdmin(BaseAdmin):
    list_display = ('username', 'first_name', 'last_name',
                    'is_staff', 'is_superuser')
    search_fields = ('username', 'first_name', 'last_name',
                     'is_staff', 'is_superuser')
    list_filter = ('username', 'first_name', 'last_name',
                   'is_staff', 'is_superuser')


admin_site.register(Category, CategoryAdmin)
admin_site.register(Vaccine, VaccineAdmin)
admin_site.register(Injection, InjectionAdmin)
admin_site.register(VaccinationCampaign, VaccinationCampaignAdmin)
admin_site.register(User, UserAdmin)
# admin.site.register()
