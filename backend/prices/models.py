from django.db import models
from django.conf import settings


class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class ItemCategory(TimeStampedModel):
    item_category_code  = models.IntegerField(primary_key=True)
    item_category       = models.CharField(max_length=16)


class Food(TimeStampedModel):
    item_code           = models.IntegerField(primary_key=True)
    item_category       = models.ForeignKey(ItemCategory, on_delete=models.CASCADE, related_name='items')
    food                = models.CharField(unique=True,max_length=16)
    image               = models.CharField(max_length=255)
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_foods')


class Kind(TimeStampedModel):
    food                = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='kinds')
    kind_code           = models.CharField(max_length=2)
    kind                = models.CharField(max_length=16)


class Country(TimeStampedModel):
    country_code        = models.IntegerField(primary_key=True)
    country             = models.CharField(max_length=16)


class ProductRank(TimeStampedModel):
    product_rank_code   = models.CharField(primary_key=True, max_length=2)
    product_rank        = models.CharField(max_length=8)
    grade_rank          = models.IntegerField()


class FoodProductRanks(TimeStampedModel):
    food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='product_ranks')
    kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='product_ranks')
    product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='foods')


class ProductCls(TimeStampedModel):
    product_cls_code    = models.CharField(primary_key=True, max_length=2)
    product_cls         = models.CharField(max_length=2)


class Unit(TimeStampedModel):
    unit                = models.CharField(primary_key=True, max_length=4)

 
class Price(TimeStampedModel):
    food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='prices')
    kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='prices')
    country             = models.ForeignKey(Country,     on_delete=models.CASCADE, related_name='prices')
    product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='prices')
    product_cls         = models.ForeignKey(ProductCls,  on_delete=models.CASCADE, related_name='prices')
    date                = models.DateField()

    unit                = models.ForeignKey(Unit,        on_delete=models.CASCADE, related_name='prices')
    price               = models.IntegerField()
    # market              = models.CharField(max_length=16)

    class Meta:
        unique_together = (('food', 'kind', 'country', 'product_rank', 'product_cls', 'date'))


class FoodComment(TimeStampedModel):
    food                = models.ForeignKey(Food,                     on_delete=models.CASCADE, related_name='comments')
    user                = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='food_comments')
    content             = models.CharField(max_length=255)
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_food_comments')