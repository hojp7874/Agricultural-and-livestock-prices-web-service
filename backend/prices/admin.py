from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(Food)
admin.site.register(Price)
admin.site.register(FoodComment)