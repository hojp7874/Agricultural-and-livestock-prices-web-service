from django.urls import path

from . import views

urlpatterns = [
    path('init-database/',                  views.InitDatabase.as_view()),
    path('data-pipeline/',                  views.DataPipeline.as_view()),
    # path('data-pipeline/',                  views.data_pipeline),
    path('foods/',                          views.FoodListView.as_view()),
    path('food-table/',                     views.food_table),
    path('foods/<int:item_code>/',          views.FoodDetailView.as_view()),
    path('foods/<int:item_code>/prices/',   views.PricesView.as_view()),
]