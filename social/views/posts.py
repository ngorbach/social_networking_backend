from django.shortcuts import render

# Create your views here.

from social.models import Post
from social.serializers import PostSerializer
from rest_framework.generics import GenericAPIView, ListAPIView, ListCreateAPIView, RetrieveUpdateDestroyAPIView
#from .permissions import IsOwnerOrReadOnly
from rest_framework.response import Response


class ListCreatePostView(ListCreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class GetUpdateDeletePostView(RetrieveUpdateDestroyAPIView):
        queryset = Post.objects.all()
        serializer_class = PostSerializer
        lookup_url_kwarg = 'post_id'


class ListPostsUser(ListAPIView):
    serializer_class = PostSerializer
    lookup_url_kwarg = 'user_id'

    def get_queryset(self):
        user_id = self.kwargs.get("user_id")
        return Post.objects.filter(user__id=user_id)


class ListPostsFollowing(ListAPIView):
    """
    get:
    List all Posts of Users the logged-in User follows.
    """
    serializer_class = PostSerializer

    def get_queryset(self):
        followed_user_ids = self.request.user.following.all().values_list("id", flat=True)
        posts = Post.objects.filter(author__in=followed_user_ids)
        return posts


class ListLikes(ListAPIView):
    """
    get:
    List all Posts bookmarked by logged-in User.
    """
    serializer_class = PostSerializer

    def get_queryset(self):
        return self.request.user.posts


class CreateLike(GenericAPIView):
    """
    post:
    Like Post for logged-in User.
    """
    serializer_class = PostSerializer
    queryset = Post.objects.all()
    lookup_url_kwarg = 'post_id'
    #permission_classes = [IsAuthenticated, IsNotOwner]

    def post(self, request, post_id):
        # get_object will return the object from the provided queryset that matches the post_id from the url
        post_to_save = self.get_object()
        user = request.user
        if post_to_save in user.liked_posts.all():
            user.liked_posts.remove(post_to_save)
            return Response(self.get_serializer(instance=post_to_save).data)
        user.liked_posts.add(post_to_save)
        return Response(self.get_serializer(instance=post_to_save).data)
