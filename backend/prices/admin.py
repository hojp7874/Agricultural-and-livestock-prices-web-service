from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(ItemCategory)
admin.site.register(Food)
admin.site.register(Kind)
admin.site.register(Country)
admin.site.register(ProductRank)
admin.site.register(ProductCls)
admin.site.register(Price)
admin.site.register(FoodComment)