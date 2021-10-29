from django.db import models
from django.conf import settings


class ItemCategory(models.Model):
    item_category_code  = models.IntegerField(primary_key=True)
    item_category       = models.CharField(max_length=16)


class Food(models.Model):
    item_code           = models.IntegerField(primary_key=True)
    item_category       = models.ForeignKey(ItemCategory, on_delete=models.CASCADE, related_name='items')
    food                = models.CharField(unique=True,max_length=16)
    image               = models.CharField(max_length=255)
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_foods')


class Kind(models.Model):
    food                = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='kinds')
    kind_code           = models.CharField(max_length=2)
    kind                = models.CharField(max_length=16)


class Country(models.Model):
    country_code        = models.IntegerField(primary_key=True)
    country             = models.CharField(max_length=16)


class ProductRank(models.Model):
    product_rank_code   = models.CharField(primary_key=True, max_length=2)
    product_rank        = models.CharField(max_length=8)
    grade_rank          = models.IntegerField()


class FoodProductRanks(models.Model):
    food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='product_ranks')
    kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='product_ranks')
    product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='foods')


class ProductCls(models.Model):
    product_cls_code    = models.CharField(primary_key=True, max_length=2)
    product_cls         = models.CharField(max_length=2)


class Unit(models.Model):
    unit                = models.CharField(primary_key=True, max_length=4)

 
class Price(models.Model):
    food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='prices')
    kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='prices')
    country             = models.ForeignKey(Country,     on_delete=models.CASCADE, related_name='prices')
    product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='prices')
    product_cls         = models.ForeignKey(ProductCls,  on_delete=models.CASCADE, related_name='prices')
    unit                = models.ForeignKey(Unit,        on_delete=models.CASCADE, related_name='prices')
    date                = models.DateField()
    market              = models.CharField(max_length=16)
    price               = models.IntegerField()


class FoodComment(models.Model):
    food                = models.ForeignKey(Food,                     on_delete=models.CASCADE, related_name='comments')
    user                = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='food_comments')
    content             = models.CharField(max_length=255)
    created_at          = models.DateTimeField(editable=False)
    modified_at         = models.DateTimeField()
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_food_comments')