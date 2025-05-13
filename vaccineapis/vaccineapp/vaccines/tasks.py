from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from .models import Injection, PrivateNotification, VaccinationCampaign, User, PublicNotification, NotificationStatus


@shared_task
def send_injection_reminder():
    # Get injections scheduled in the next 3 days
    three_days_from_now = timezone.now() + timedelta(days=3)
    upcoming_injections = Injection.objects.filter(
        injection_time__lte=three_days_from_now,
        injection_time__gt=timezone.now(),
        status='NOT_VACCINATED'
    ).select_related('user', 'vaccine')

    for injection in upcoming_injections:
        # Create notification
        title = f"NHẮC NHỞ: Lịch tiêm {injection.vaccine.name} sắp đến"
        print(injection.vaccine)
        message = f"Bạn có lịch tiêm {injection.vaccine.name} trong vòng 3 ngày tới. "
        message += f"Vui lòng chuẩn bị và đến đúng giờ!"

        PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )



