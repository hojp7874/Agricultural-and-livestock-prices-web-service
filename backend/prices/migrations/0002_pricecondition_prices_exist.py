# Generated by Django 3.2.8 on 2021-12-12 14:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('prices', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='pricecondition',
            name='prices_exist',
            field=models.BooleanField(default=False),
        ),
    ]
