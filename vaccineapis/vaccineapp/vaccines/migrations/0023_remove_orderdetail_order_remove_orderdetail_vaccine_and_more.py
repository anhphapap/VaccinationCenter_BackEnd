# Generated by Django 5.2 on 2025-05-18 08:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0022_alter_order_vnp_bankcode_alter_order_vnp_cardtype_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='orderdetail',
            name='order',
        ),
        migrations.RemoveField(
            model_name='orderdetail',
            name='vaccine',
        ),
        migrations.DeleteModel(
            name='Order',
        ),
        migrations.DeleteModel(
            name='OrderDetail',
        ),
    ]
