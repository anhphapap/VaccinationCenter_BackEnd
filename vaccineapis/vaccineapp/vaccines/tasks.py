from celery import shared_task
from django.utils import timezone
from datetime import timedelta  
from .models import Injection, PrivateNotification, VaccinationCampaign, User, PublicNotification, NotificationStatus


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

        PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )


@shared_task
def send_campaign_notification(campaign_id):
    from .models import VaccinationCampaign
    try:
        campaign = VaccinationCampaign.objects.get(id=campaign_id)

        # Create public notification
        notification = PublicNotification.objects.create(
            title=f"Đợt tiêm chủng mới: {campaign.name}",
            message=campaign.description,
            vaccine_campaign=campaign
        )

        # Create notification status for all active users
        users = User.objects.filter(is_active=True)
        notification_statuses = [
            NotificationStatus(
                user=user,
                public_notification=notification,
                is_read=False
            ) for user in users
        ]
        NotificationStatus.objects.bulk_create(notification_statuses)

        return f"Successfully sent notifications for campaign {campaign.name}"
    except VaccinationCampaign.DoesNotExist:
        return f"Campaign with id {campaign_id} does not exist"
