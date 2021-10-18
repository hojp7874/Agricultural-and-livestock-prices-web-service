from django.db import models
from django.conf import settings

# Create your models here.
class Food(models.Model):
    item_code       = models.IntegerField(primary_key=True)
    name            = models.CharField(unique=True,max_length=16)
    image           = models.CharField(max_length=255)
    like_users      = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_foods')


class Price(models.Model):
    # unique below zip
    food            = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='prices')
    kind_code       = models.IntegerField()
    country         = models.CharField(max_length=16)
    market          = models.CharField(max_length=16)
    date            = models.DateField()

    price           = models.IntegerField()
    product_rank    = models.IntegerField()
    product_cls     = models.IntegerField()


class FoodComment(models.Model):
    food            = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='comments')
    user            = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='food_comments')
    content         = models.CharField(max_length=255)
    created_at      = models.DateTimeField(editable=False)
    modified_at     = models.DateTimeField()
    like_users      = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_food_comments')