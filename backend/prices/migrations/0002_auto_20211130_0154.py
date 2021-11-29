# Generated by Django 3.2.8 on 2021-11-29 16:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('prices', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='productrank',
            name='kinds',
        ),
        migrations.AddField(
            model_name='kind',
            name='product_ranks',
            field=models.ManyToManyField(blank=True, related_name='kinds', to='prices.ProductRank'),
        ),
    ]
