from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from .models import Injection, Notification

@shared_task
def send_injection_reminder():
    # Get injections scheduled in the next 5 minutes
    five_minutes_from_now = timezone.now() + timedelta(minutes=5)
    upcoming_injections = Injection.objects.filter(
        injection_time__lte=five_minutes_from_now,
        injection_time__gt=timezone.now(),
        status='NOT_VACCINATED'
    ).select_related('user', 'vaccine')

    for injection in upcoming_injections:
        # Create notification
        title = f"NHẮC NHỞ: Lịch tiêm {injection.vaccine.name} sắp đến"
        message = f"Bạn có lịch tiêm {injection.vaccine.name} trong 5 phút nữa. "
        message += f"Vui lòng chuẩn bị và đến đúng giờ!"

        Notification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )
