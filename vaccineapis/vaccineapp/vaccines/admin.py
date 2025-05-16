from django.contrib import admin
from vaccines.models import Category, Vaccine, Injection, VaccinationCampaign, User, PublicNotification, NotificationStatus
from django.utils import timezone


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
    fieldsets = (
        ('Thông tin cơ bản', {
            'fields': ('name', 'description', 'vaccine')
        }),
        ('Thời gian', {
            'fields': ('start_date', 'end_date')
        }),
        ('Thông báo', {
            'fields': ('send_notification',),
            'description': 'Chọn để gửi thông báo công khai đến tất cả người dùng khi tạo đợt tiêm mới'
        }),
    )

    def save_model(self, request, obj, form, change):
        # Lưu campaign trước
        super().save_model(request, obj, form, change)

        # Nếu là tạo mới (không phải update) và được chọn gửi thông báo
        if not change and obj.send_notification:
            # Tạo thông báo công khai
            notification = PublicNotification.objects.create(
                title=f"Đợt tiêm mới: {obj.name}",
                message=f"Đã có đợt tiêm mới: {obj.name}\n"
                f"Thời gian: Từ {obj.start_date.strftime('%d/%m/%Y')} đến {obj.end_date.strftime('%d/%m/%Y')}\n"
                f"Mô tả: {obj.description}",
                vaccine_campaign=obj
            )

            # Tạo trạng thái thông báo cho tất cả người dùng
            users = User.objects.filter(is_active=True)
            notification_statuses = [
                NotificationStatus(
                    user=user,
                    public_notification=notification,
                    is_read=False
                ) for user in users
            ]
            # Sử dụng bulk_create để tạo nhiều bản ghi cùng lúc
            NotificationStatus.objects.bulk_create(notification_statuses)

            # Reset trạng thái gửi thông báo
            obj.send_notification = False
            obj.save()


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
