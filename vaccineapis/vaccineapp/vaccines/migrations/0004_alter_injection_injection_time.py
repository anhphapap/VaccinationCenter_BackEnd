# Generated by Django 5.2 on 2025-06-08 11:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0003_alter_order_options_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='injection',
            name='injection_time',
            field=models.DateField(),
        ),
    ]
