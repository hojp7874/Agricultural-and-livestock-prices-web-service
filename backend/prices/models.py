from django.db import models
from django.conf import settings


class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class ItemCategory(models.Model):
    item_category_code  = models.IntegerField(primary_key=True)
    item_category       = models.CharField(max_length=16, unique=True)


class Food(models.Model):
    item_code           = models.IntegerField(primary_key=True)
    item_category       = models.ForeignKey(ItemCategory, on_delete=models.CASCADE, related_name='items')
    food                = models.CharField(unique=True, max_length=16)
    wholesale_unit      = models.CharField(max_length=8, null=True)
    retail_unit         = models.CharField(max_length=8, null=True)
    image               = models.CharField(max_length=255)
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_foods')


class ProductRank(models.Model):
    product_rank_code   = models.CharField(primary_key=True, max_length=2)
    product_rank        = models.CharField(max_length=8)
    grade_rank          = models.IntegerField()


class Kind(models.Model):
    food                = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='kinds')
    kind_code           = models.CharField(max_length=2)
    kind                = models.CharField(max_length=16)
    product_ranks       = models.ManyToManyField(ProductRank, blank=True, related_name='kinds')

    class Meta:
        unique_together = (('food', 'kind_code'))


class Country(models.Model):
    country_code        = models.IntegerField(primary_key=True)
    country             = models.CharField(max_length=16, unique=True)


class ProductCls(models.Model):
    product_cls_code    = models.CharField(primary_key=True, max_length=2)
    product_cls         = models.CharField(max_length=2, unique=True)


class PriceCondition(models.Model):
    # food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='conditions')
    kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='conditions')
    country             = models.ForeignKey(Country,     on_delete=models.CASCADE, related_name='conditions')
    product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='conditions')
    product_cls         = models.ForeignKey(ProductCls,  on_delete=models.CASCADE, related_name='conditions')
    prices_exists       = models.BooleanField(default=False)

    class Meta:
        unique_together = (('kind', 'country', 'product_rank', 'product_cls'))
        indexes = [
            models.Index(fields=('kind', 'country', 'product_rank', 'product_cls', 'prices_exists'))
        ]


class Price(models.Model):
    # food                = models.ForeignKey(Food,        on_delete=models.CASCADE, related_name='prices')
    # kind                = models.ForeignKey(Kind,        on_delete=models.CASCADE, related_name='prices')
    # country             = models.ForeignKey(Country,     on_delete=models.CASCADE, related_name='prices')
    # product_rank        = models.ForeignKey(ProductRank, on_delete=models.CASCADE, related_name='prices')
    # product_cls         = models.ForeignKey(ProductCls,  on_delete=models.CASCADE, related_name='prices')

    condition           = models.ForeignKey(PriceCondition, on_delete=models.CASCADE, related_name='prices')
    date                = models.DateField()
    price               = models.IntegerField()

    class Meta:
        unique_together = (('condition', 'date'))
        indexes = [
            models.Index(fields=('condition', 'date'))
        ]


class FoodComment(TimeStampedModel):
    food                = models.ForeignKey(Food,                     on_delete=models.CASCADE, related_name='comments')
    user                = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='food_comments')
    content             = models.CharField(max_length=255)
    like_users          = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='like_food_comments')