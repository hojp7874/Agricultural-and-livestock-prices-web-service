from django.urls import path

from . import views

urlpatterns = [
    path('init-database/',                          views.InitDatabase.as_view()),
    path('data-pipeline/',                          views.DataPipeline.as_view()),
    path('food-table/',                             views.food_table),
    path('foods/',                                  views.get_foods),
    path('foods/<int:item_code>/',                  views.get_food_detail),
    path('foods/<int:item_code>/prices/',           views.get_prices),
    path('foods/<int:item_code>/prices-conditions/',views.prices_conditions),
    path('countries/',                              views.get_countries),
    path('price-condition/price-exists/',           views.check_valid_price_condition),
]