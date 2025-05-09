from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from .models import Injection, Notification


@shared_task
def check_upcoming_injections():
    # Get injections scheduled for the next 3 days
    three_days_from_now = timezone.now() + timedelta(days=3)
    upcoming_injections = Injection.objects.filter(
        injection_time__lte=three_days_from_now,
        injection_time__gt=timezone.now(),
        status='NOT_VACCINATED'
    ).select_related('user', 'vaccine')

    for injection in upcoming_injections:
        days_until = (injection.injection_time - timezone.now()).days

        # Create notification
        title = f"Lịch tiêm {injection.vaccine.name} sắp đến"
        message = f"Bạn có lịch tiêm {injection.vaccine.name} vào ngày {injection.injection_time.strftime('%d/%m/%Y')}. "
        message += f"Còn {days_until} ngày nữa là đến hạn tiêm."

        Notification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )
