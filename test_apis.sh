#------------------------------------------------------------------------
#                        CONSTANTS: ENDPOINTS
#------------------------------------------------------------------------
HOST_URL=http://127.0.0.1:8000/backend/api/

# Auth
GET_TOKEN_API=auth/token/
VERIFY_TOKEN_API=auth/token/verify/
REFRESH_TOKEN_API=auth/token/refresh/

# Social - Posts
POST_API=social/posts/
READ_POST_API=social/posts/1/
PUT_POST_API=social/posts/1/
PATCH_POST_API=social/posts/1/
DELETE_POST_API=social/posts/1/
LIST_LIKED_POSTS_API=social/posts/likes/
TOGGLE_LIKE_POST_API=social/posts/toggle-like/1/

# Social - Follow
TOGGLE_FOLLOW_USER_API=social/toggle-follow/1/
LIST_FOLLOWING_API=social/following/
LIST_FOLLOWERS_API=social/followers/

# Users
USERS_API=users/

#------------------------------------------------------------------------
#                              AUTH
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                 AUTH: GET TOKEN API (POST REQUEST)
#------------------------------------------------------------------------
get_token_endpoint=$HOST_URL$GET_TOKEN_API

reponse=$(curl --request POST --url $get_token_endpoint --data password=propulsion \
--data email=nico@email.com)
refresh_token=$(echo $reponse | sed "s/{.*\"refresh\":\"\([^\"]*\).*}/\1/g")
access_token=$(echo $reponse | sed "s/{.*\"access\":\"\([^\"]*\).*}/\1/g")

#------------------------------------------------------------------------
#                 AUTH: VERIFY TOKEN API (POST REQUEST)
#------------------------------------------------------------------------
verify_token_endpoint=$HOST_URL$VERIFY_TOKEN_API

curl --request POST --url $verify_token_endpoint --data token=$access_token

#------------------------------------------------------------------------
#                 AUTH: REFRESH TOKEN API (POST REQUEST)
#------------------------------------------------------------------------
refresh_token_endpoint=$HOST_URL$REFRESH_TOKEN_API

reponse=$(curl --request POST --url $refresh_token_endpoint --data refresh=$refresh_token)
access_token=$(echo $reponse | sed "s/{.*\"access\":\"\([^\"]*\).*}/\1/g")



#------------------------------------------------------------------------
#                            SOCIAL - POSTS
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#               SOCIAL: CREATE POST API (POST REQUEST)
#------------------------------------------------------------------------
create_post_endpoint=$HOST_URL$POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request POST --url $create_post_endpoint --data content='This is a new post' \
--data title='Post title'

#------------------------------------------------------------------------
#                SOCIAL: LIST POSTS API (GET REQUEST)
#------------------------------------------------------------------------
list_posts_endpoint=$HOST_URL$POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $list_posts_endpoint

#------------------------------------------------------------------------
#                SOCIAL: READ POST API (GET REQUEST)
#------------------------------------------------------------------------
read_post_endpoint=$HOST_URL$READ_POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $read_post_endpoint

#------------------------------------------------------------------------
#                SOCIAL: UPDATE POST API (PUT REQUEST)
#------------------------------------------------------------------------
put_post_endpoint=$HOST_URL$PUT_POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request PUT --url $put_post_endpoint --data content='This is a changed post using put'

#------------------------------------------------------------------------
#              SOCIAL: PARTIAL UPDATE POST API (PATCH REQUEST)
#------------------------------------------------------------------------
patch_post_endpoint=$HOST_URL$PATCH_POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request PATCH --url $patch_post_endpoint --data content='This is a changed post using patch'

#------------------------------------------------------------------------
#                SOCIAL: DELETE POST API (DELETE REQUEST)
#------------------------------------------------------------------------
#delete_post_endpoint=$HOST_URL$DELETE_POST_API
#
#curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
#--request DELETE --url $read_post_endpoint

#------------------------------------------------------------------------
#                SOCIAL: TOGGLE-LIKE POST API (POST REQUEST)
#------------------------------------------------------------------------
toggle_like_post_endpoint=$HOST_URL$TOGGLE_LIKE_POST_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request POST --url $toggle_like_post_endpoint

#------------------------------------------------------------------------
#                SOCIAL: LIST LIKED POST API (POST REQUEST)
#------------------------------------------------------------------------
list_liked_posts_endpoint=$HOST_URL$LIST_LIKED_POSTS_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $list_liked_posts_endpoint



#------------------------------------------------------------------------
#                            SOCIAL - FOLLOW
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                SOCIAL: TOGGLE-FOLLOW USER API (POST REQUEST)
#------------------------------------------------------------------------
toggle_follow_user_endpoint=$HOST_URL$TOGGLE_FOLLOW_USER_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request POST --url $toggle_follow_user_endpoint

#------------------------------------------------------------------------
#                SOCIAL: LIST FOLLOWING API (POST REQUEST)
#------------------------------------------------------------------------
list_following_endpoint=$HOST_URL$LIST_FOLLOWING_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $list_following_endpoint

#------------------------------------------------------------------------
#                SOCIAL: LIST FOLLOWERS API (POST REQUEST)
#------------------------------------------------------------------------
list_followers_endpoint=$HOST_URL$LIST_FOLLOWERS_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $list_followers_endpoint





#------------------------------------------------------------------------
#                                 USERS
#------------------------------------------------------------------------

#------------------------------------------------------------------------
#                USERS: LIST POSTS API (GET REQUEST)
#------------------------------------------------------------------------
list_posts_endpoint=$HOST_URL$USERS_API

curl -H "Accept: application/json" -H "Authorization: Bearer ${access_token}" \
--request GET --url $list_posts_endpoint