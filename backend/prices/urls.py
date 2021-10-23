from django.urls import path

from . import views

urlpatterns = [
    path('data-pipeline/',                  views.data_pipeline),
    # path('init-database/',                  views.init_database),
    path('init-database/',                  views.InitDatabase.as_view()),
    path('foods/',                          views.FoodListView.as_view()),
    path('foods/<int:item_code>/',          views.FoodDetailView.as_view()),
    path('foods/<int:item_code>/prices/',   views.PricesView.as_view()),
]