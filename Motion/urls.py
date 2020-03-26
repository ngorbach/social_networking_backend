"""Motion URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from rest_framework.documentation import include_docs_urls

urlpatterns = [
    path('backend/admin/', admin.site.urls),
    path('backend/docs/', include_docs_urls(title='Django Template', schema_url='/', permission_classes=[])),
]

from rest_framework_simplejwt import views as jwt_views

urlpatterns.append(path('backend/api/auth/token/', jwt_views.TokenObtainPairView.as_view())),
urlpatterns.append(path('backend/api/auth/token/refresh/', jwt_views.TokenRefreshView.as_view())),
urlpatterns.append(path('backend/api/auth/token/verify/', jwt_views.TokenVerifyView.as_view()))

from django.urls import include
urlpatterns.append(path('backend/api/users/', include('users.urls')))

from django.urls import include
urlpatterns.append(path('backend/api/social/', include('social.urls')))
