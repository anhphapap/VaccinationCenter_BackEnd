# Generated by Django 5.2 on 2025-05-08 10:21

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0014_injection_note_injection_status_alter_user_avatar_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='vaccine',
            name='manual',
        ),
        migrations.RemoveField(
            model_name='vaccine',
            name='origin',
        ),
        migrations.RemoveField(
            model_name='vaccine',
            name='preserve',
        ),
        migrations.RemoveField(
            model_name='vaccine',
            name='recommend',
        ),
    ]
