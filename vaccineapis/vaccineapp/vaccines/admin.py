import html
from django.contrib import admin
from .models import Category, Vaccine, User, VaccinationCampaign, Dose, Injection, PrivateNotification, PublicNotification, NotificationStatus, Order, OrderDetail, InjectionStatus
from django.utils import timezone
from django.urls import path
from django.utils.safestring import mark_safe
from django.db.models import Count, Sum
import json
from django.template.response import TemplateResponse


class VaccineAppAdmin(admin.AdminSite):
    site_header = ' TRUNG TÂM VACCINE PV'
    site_title = ' TRUNG TÂM VACCINE PV'
    index_title = 'Quản lý'

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('statistics/', self.admin_view(self.dashboard_view),
                 name='dashboard'),
        ]
        return custom_urls + urls

    def dashboard_view(self, request):
        now = timezone.now()
        start_of_month = now.replace(
            day=1, hour=0, minute=0, second=0, microsecond=0)
        start_of_year = now.replace(
            month=1, day=1, hour=0, minute=0, second=0, microsecond=0)

        # so luong nguoi tiem theo thang
        monthly_injections_count = Injection.objects.filter(
            injection_time__gte=start_of_month,
            injection_time__lte=now
        ).count()
        # so luong nguoi tiem theo nam
        yearly_injections_count = Injection.objects.filter(
            injection_time__gte=start_of_year,
            injection_time__lte=now
        ).count()

        # ty le tiem thanh cong theo thang
        monthly_vaccinated_count = Injection.objects.filter(
            injection_time__gte=start_of_month,
            injection_time__lte=now,
            status=InjectionStatus.VACCINATED.value
        ).count()
        if monthly_vaccinated_count > 0:
            monthly_success_rate = monthly_vaccinated_count / monthly_injections_count * 100
        else:
            monthly_success_rate = 0

        # ty le tiem thanh cong theo nam
        yearly_vaccinated_count = Injection.objects.filter(
            injection_time__gte=start_of_year,
            injection_time__lte=now,
            status=InjectionStatus.VACCINATED.value).count()
        if yearly_vaccinated_count > 0:
            yearly_success_rate = yearly_vaccinated_count / yearly_injections_count * 100
        else:
            yearly_success_rate = 0

        # doanh thu theo thang
        monthly_revenue = Order.objects.filter(
            created_date__gte=start_of_month,
            created_date__lte=now,
            vnp_ResponseCode='00'
        ).aggregate(total_revenue=Sum('amount'))['total_revenue']

        # doanh thu theo nam
        yearly_revenue = Order.objects.filter(
            created_date__gte=start_of_year,
            created_date__lte=now,
            vnp_ResponseCode='00'  # Mã phản hồi thành công từ VNPAY
        ).aggregate(total_revenue=Sum('amount'))['total_revenue']

        # so luong vaccine da mua trong thang
        monthly_purchased_vaccines = OrderDetail.objects.filter(
            order__created_date__gte=start_of_month,
            order__created_date__lte=now,
            order__vnp_ResponseCode='00'
        ).count()

        # so luong vaccine da mua trong nam
        yearly_purchased_vaccines = OrderDetail.objects.filter(
            order__created_date__gte=start_of_year,
            order__created_date__lte=now,
            order__vnp_ResponseCode='00'
        ).count()

        # thong ke vaccine da mua trong thang
        popular_vaccines = OrderDetail.objects.filter(
            order__created_date__gte=start_of_month,
            order__created_date__lte=now,
            order__vnp_ResponseCode='00'
        ).values('vaccine__name').annotate(
            total_quantity=Count('id')
        ).order_by('-total_quantity')[:10]

        # thong ke vaccine da mua trong quy
        current_quarter = (now.month - 1) // 3 + 1
        start_of_quarter = now.replace(
            month=3 * current_quarter - 2, day=1, hour=0, minute=0, second=0, microsecond=0)

        popular_vaccines_quarterly = OrderDetail.objects.filter(
            order__created_date__gte=start_of_quarter,
            order__created_date__lte=now,
            order__vnp_ResponseCode='00'
        ).values('vaccine__name').annotate(
            total_quantity=Count('id')
        ).order_by('-total_quantity')[:10]

        # thong ke vaccine da mua trong nam
        popular_vaccines_yearly = OrderDetail.objects.filter(
            order__created_date__gte=start_of_year,
            order__created_date__lte=now,
            order__vnp_ResponseCode='00'
        ).values('vaccine__name').annotate(
            total_quantity=Count('id')
        ).order_by('-total_quantity')[:10]

        vaccine_labels = [item['vaccine__name'] for item in popular_vaccines]
        vaccine_data = [item['total_quantity'] for item in popular_vaccines]

        vaccine_label_quarter = [item['vaccine__name']
                                    for item in popular_vaccines_quarterly]
        vaccine_data_quarter = [item['total_quantity']
                                  for item in popular_vaccines_quarterly]

        vaccine_labels_yearly = [item['vaccine__name']
                                 for item in popular_vaccines_yearly]
        vaccine_data_yearly = [item['total_quantity']
                               for item in popular_vaccines_yearly]

        context = {
            'title': 'Thống kê',
            'monthly_injections_count': monthly_injections_count,
            'monthly_success_rate': round(monthly_success_rate, 2),
            'monthly_revenue': monthly_revenue,
            'monthly_purchased_vaccines': monthly_purchased_vaccines,
            'yearly_injections_count': yearly_injections_count,
            'yearly_success_rate': round(yearly_success_rate, 2),
            'yearly_revenue': yearly_revenue,
            'yearly_purchased_vaccines': yearly_purchased_vaccines,

            'vaccine_labels': json.dumps(vaccine_labels),
            'vaccine_data': json.dumps(vaccine_data),
            'vaccine_labels_quarterly': json.dumps(vaccine_label_quarter),
            'vaccine_data_quarterly': json.dumps(vaccine_data_quarter),
            'vaccine_labels_yearly': json.dumps(vaccine_labels_yearly),
            'vaccine_data_yearly': json.dumps(vaccine_data_yearly),
            'current_quarter': current_quarter,
            'opts': Category._meta,
        }
        return TemplateResponse(request, 'admin/chart.html', context)


admin_site = VaccineAppAdmin()


class BaseAdmin(admin.ModelAdmin):
    list_per_page = 30


class CategoryAdmin(BaseAdmin):
    list_display = ('name',)
    search_fields = ('name',)
    list_filter = ('name',)
    readonly_fields = ['image_view']

    def image_view(self, obj):
        return mark_safe(f"<img src='{obj.image}' width='120' />")


class VaccineAdmin(BaseAdmin):
    list_display = ('name', 'disease', 'price')
    search_fields = ('name', 'disease', 'price')
    list_filter = ('name', 'disease', 'price')
    filter_horizontal = ('cates',)
    readonly_fields = ['image_view']

    def image_view(self, obj):
        return mark_safe(f"<img src='{obj.image}' width='500' />")


class InjectionAdmin(BaseAdmin):
    list_display = ('vaccine', 'user',
                    'vaccination_campaign', 'injection_time', 'status')
    search_fields = ('vaccine', 'user',
                     'vaccination_campaign', 'injection_time', 'status')
    list_filter = ('vaccine', 'user', 'vaccination_campaign',
                   'injection_time', 'status')
    list_editable = ('status',)


class VaccinationCampaignAdmin(BaseAdmin):
    list_display = ('name', 'start_date', 'end_date')
    search_fields = ('name', 'start_date', 'end_date')
    list_filter = ('name', 'start_date', 'end_date')
    fieldsets = (
        ('Thông báo', {
            'fields': ('send_notification',),
            'description': 'Chọn để gửi thông báo công khai đến tất cả người dùng khi tạo đợt tiêm mới'
        }),
    )
    def save_model(self, request, obj, form, change):
        super().save_model(request, obj, form, change)

        if not change and obj.send_notification:
            notification = PublicNotification.objects.create(
                title=f"Đợt tiêm mới: {obj.name}",
                message=f"Đã có đợt tiêm mới: {obj.name}\n"
                f"Thời gian: Từ {obj.start_date.strftime('%d/%m/%Y')} đến {obj.end_date.strftime('%d/%m/%Y')}\n",
                vaccine_campaign=obj
            )

            users = User.objects.filter(is_active=True)
            notification_statuses = [
                NotificationStatus(
                    user=user,
                    public_notification=notification,
                    is_read=False
                ) for user in users
            ]
            NotificationStatus.objects.bulk_create(notification_statuses)

            obj.send_notification = False
            obj.save()


class OrderAdmin(BaseAdmin):
    list_display = ('order_id', 'user', 'amount',
                    'vnp_ResponseCode', 'vnp_PayDate')
    search_fields = ('order_id', 'user', 'amount',
                     'vnp_ResponseCode', 'vnp_PayDate')
    list_filter = ('order_id', 'user', 'amount',
                   'vnp_ResponseCode', 'vnp_PayDate')
    list_editable = ('vnp_ResponseCode',)


class UserAdmin(BaseAdmin):
    list_display = ('username', 'first_name', 'last_name',
                    'is_staff', 'is_superuser')
    search_fields = ('username', 'first_name', 'last_name',
                     'is_staff', 'is_superuser')
    list_filter = ('username', 'first_name', 'last_name',
                   'is_staff', 'is_superuser')
    readonly_fields = ['image_view']

    def image_view(self, obj):
        return mark_safe(f"<img src='{obj.image}' width='120' />")



admin_site.register(Category, CategoryAdmin)
admin_site.register(Vaccine, VaccineAdmin)
admin_site.register(Injection, InjectionAdmin)
admin_site.register(VaccinationCampaign, VaccinationCampaignAdmin)
admin_site.register(User, UserAdmin)
admin_site.register(Order, OrderAdmin)
# admin.site.register()
