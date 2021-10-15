from django.urls import path

from . import views

urlpatterns = [
    path('food/',                   views.FoodListView.as_view()),
    path('food/<int:item_code>/',   views.PriceView.as_view()),
]