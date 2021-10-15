# Generated by Django 3.2.8 on 2021-10-15 02:52

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Food',
            fields=[
                ('item_code', models.IntegerField(max_length=3, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=16, unique=True)),
                ('image', models.CharField(max_length=255)),
                ('like_users', models.ManyToManyField(related_name='like_foods', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Price',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.IntegerField()),
                ('date', models.DateField()),
                ('kind_code', models.IntegerField(max_length=2)),
                ('product_rank', models.IntegerField(max_length=2)),
                ('country', models.CharField(max_length=16)),
                ('product_cls', models.IntegerField(max_length=2)),
                ('food', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='prices', to='prices.food')),
            ],
        ),
        migrations.CreateModel(
            name='FoodComment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=255)),
                ('created_at', models.DateTimeField(editable=False)),
                ('modified_at', models.DateTimeField()),
                ('food', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comments', to='prices.food')),
                ('like_users', models.ManyToManyField(related_name='like_food_comments', to=settings.AUTH_USER_MODEL)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='food_comments', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]