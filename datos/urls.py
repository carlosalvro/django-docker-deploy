from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('ver/', views.show_data, name='show_data'),
    path('crear/', views.create_data, name='create_data'),
]