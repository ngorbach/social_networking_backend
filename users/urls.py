from django.urls import path

from .views import ListCreateUserView, GetUpdateDeleteUserView

urlpatterns = [
    path('', ListCreateUserView.as_view()),
    path('<int:user_id>/', GetUpdateDeleteUserView.as_view())
]
