from django.contrib.auth import get_user_model
from rest_framework import serializers

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    logged_in_user_is_following = serializers.SerializerMethodField()
    amount_of_posts = serializers.SerializerMethodField()
    amount_of_likes = serializers.SerializerMethodField()
    amount_of_friends = serializers.SerializerMethodField()
    amount_of_followers = serializers.SerializerMethodField()
    amount_following = serializers.SerializerMethodField()
    logged_in_user_sent_fr = serializers.SerializerMethodField()

    
    class Meta:
        model = User
        exclude = ['password']
        
    def get_logged_in_user_is_following(self, user):
        logged_in_user = self.context['request'].user
        return user.id in [user.id for user in logged_in_user.following.all()]

    @staticmethod
    def get_amount_of_posts(user):
        return user.posts.all().count()

    @staticmethod
    def get_amount_of_likes(user):
        return sum([post.liked_by.all().count() for post in user.posts.all()])

    @staticmethod
    def get_amount_of_friends(user):
        return user.friends.all().count()

    @staticmethod
    def get_amount_of_followers(user):
        return user.followers.all().count()

    @staticmethod
    def get_amount_following(user):
        return user.following.all().count()

    def get_logged_in_user_sent_fr(self,user):
        logged_in_user = self.context['request'].user
        return user.id in [user.id for user in logged_in_user.sent_friend_request.all()]