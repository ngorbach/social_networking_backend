from users.serializers import UserSerializer
from rest_framework.generics import GenericAPIView, ListAPIView, ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from django.contrib.auth import get_user_model
User = get_user_model()


class ListFollowers(ListAPIView):
    """
    get:
    List all followers of the logged-in User.
    """
    serializer_class = UserSerializer
    queryset = User.objects.all()

    def filter_queryset(self, queryset):
        return self.request.user.followers


class ListFollowing(ListAPIView):
    """
    get:
    List all Users the logged-in User is following.
    """
    serializer_class = UserSerializer
    queryset = User.objects.all()

    def filter_queryset(self, queryset):
        return self.request.user.following


class ToggleFollowUser(GenericAPIView):
    """
    post:
    Toggle following User.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    #permission_classes = [IsAuthenticated, ObjNotLoggedInUser]
    lookup_url_kwarg = 'user_id'

    def post(self, request, **kwargs):
        target_user = self.get_object()
        user = request.user
        if target_user in user.following.all():
            user.following.remove(target_user)
            return Response(self.get_serializer(instance=target_user).data)
        user.following.add(target_user)
        return Response(self.get_serializer(instance=target_user).data)