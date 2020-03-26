
from django.urls import path

from .views.follow import ListFollowers, ListFollowing, ToggleFollowUser
from .views.friends import ToggleFriendRequest
from .views.posts import ListCreatePostView, GetUpdateDeletePostView, ListPostsUser, ListPostsFollowing, ListLikes, CreateLike

urlpatterns = [
    path('posts/', ListCreatePostView.as_view()),
    path('posts/<int:post_id>/', GetUpdateDeletePostView.as_view()),
    path('posts/user/<int:user_id>/', ListPostsUser.as_view(), name='list-posts-user'),
    path("posts/following/", ListPostsFollowing.as_view(), name="list-posts-followees"),
    path("posts/likes/", ListLikes.as_view(), name="list-liked-posts"),
    path("posts/toggle-like/<int:post_id>/", CreateLike.as_view(), name="toggle-like"),
    path('followers/', ListFollowers.as_view(), name='list-followers'),
    path('following/', ListFollowing.as_view(), name='list-following'),
    path('toggle-follow/<int:user_id>/', ToggleFollowUser.as_view(), name='toggle-follow-user'),
    path('friends/request/<int:user_id>/', ToggleFriendRequest.as_view(), name='toggle-friend-request')
]