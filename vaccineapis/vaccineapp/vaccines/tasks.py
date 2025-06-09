from celery import shared_task
from django.conf import settings
from django.utils import timezone
from datetime import timedelta

import redis
from .models import Injection, PrivateNotification, VaccinationCampaign, User, PublicNotification, NotificationStatus
from django.core.mail import send_mail


@shared_task(name='vaccines.tasks.send_injection_reminder')
def send_injection_reminder():
    now = timezone.now()
    tomorrow = now + timedelta(days=1)

    upcoming_injections = Injection.objects.filter(
        injection_time__gte=now,
        injection_time__lte=tomorrow,
        status='NOT_VACCINATED'
    ).select_related('user', 'vaccine')

    for injection in upcoming_injections:
        is_today = injection.injection_time == now.date()

        if is_today:
            title = f"NHẮC NHỞ: Hôm nay là ngày tiêm {injection.vaccine.name}"
            message = f"Bạn có lịch tiêm {injection.vaccine.name} vào hôm nay. "
            message += f"Vui lòng đến đúng giờ và mang theo giấy tờ cần thiết!"
        else:
            title = f"NHẮC NHỞ: Ngày mai là ngày tiêm {injection.vaccine.name}"
            message = f"Bạn có lịch tiêm {injection.vaccine.name} vào ngày mai. "
            message += f"Vui lòng chuẩn bị và đến đúng giờ!"

        new_notification = PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )
        send_notification_email(new_notification)


@shared_task(name='vaccines.tasks.update_campaign_status')
def update_campaign_status():
    now = timezone.now()
    active_campaigns = VaccinationCampaign.objects.filter(active=True)

    for campaign in active_campaigns:
        if campaign.end_date.date() < now.date():
            campaign.active = False
            campaign.save()


@shared_task(name='vaccines.tasks.update_missed_injections')
def update_missed_injections():
    now = timezone.now()

    missed_injections = Injection.objects.filter(
        injection_time__lt=now,
        status='NOT_VACCINATED',
        active=True
    ).select_related('user', 'vaccine')

    for injection in missed_injections:
        injection.status = 'MISSED'
        injection.save()

        title = f"THÔNG BÁO: Bỏ lỡ lịch tiêm {injection.vaccine.name}"
        message = f"Bạn đã bỏ lỡ lịch tiêm {injection.vaccine.name} vào {injection.injection_time.strftime('ngày %d/%m/%Y')}. "
        message += "Vui lòng liên hệ với trung tâm để được tư vấn lịch tiêm mới."

        new_notification = PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )

        send_notification_email(new_notification)


def send_notification_email(notification):
    subject = notification.title
    message = notification.message
    from_email = settings.DEFAULT_FROM_EMAIL
    recipient_list = [notification.user.email]

    try:
        send_mail(subject, message, from_email, recipient_list)
        print(f"Email sent successfully to {notification.user.email}")
    except Exception as e:
        print(f"Failed to send email to {notification.user.email}: {e}")
