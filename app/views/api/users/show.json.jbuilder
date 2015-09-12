json.extract! @user,
  :id,
  :name,
  :born_on,
  :profile_pic,
  :cover_pic,
  :city,
  :school,
  :workplace

if current_user.friends.include?(@user)
  json.friendship_status "un-friend"

  friendshipIDs = Friendship.where(
    '(user_id = :id AND friend_id = :friend_id) OR
      user_id = :friend_id AND friend_id = :id',
     id: current_user.id, friend_id: @user.id
  ).pluck(:id)

  json.friendshipIDs friendshipIDs

elsif current_user.unsuccessful_requests.pluck(:friend_id).include?(@user.id)
  json.friendship_status "friend-request-sent"
elsif current_user.friend_requests.pluck(:user_id).include?(@user.id)
  json.friendship_status "accept-friend-request"

  friend_request_id = FriendRequest.where(
    '(user_id = :id AND friend_id = :friend_id)',
     id: @user.id, friend_id: current_user.id
  ).pluck(:id).last.to_i

  json.friendRequest friend_request_id

elsif current_user == @user
  json.friendship_status "user-himself"
else
  json.friendship_status "add-friend"
end

json.friends @user.friends do |friend|
  json.extract! friend, :id, :name, :profile_pic, :school
end

json.unsuccessful_requests @user.unsuccessful_requests.includes(:friend) do |friendship|
  json.extract! friendship, :id, :friend_id
  json.name friendship.friend.name
  # json.name User.find(friendship.friend_id).name
end

json.friend_requests @user.friend_requests.includes(:user) do |friendship|
  json.extract! friendship, :id, :user_id
  json.name friendship.user.name
  json.requestor_id friendship.user.id
  json.profile_pic friendship.user.profile_pic
end

# if current_user.id != @user.id
#   mutual_friends = []
#   current_user.friends.each do |friend|
#     if @user.friends.include?(friend)
#       mutual_friends << friend
#     end
#   end
#   json.mutual_friends mutual_friends do |friend|
#     json.extract! friend, :name
#   end
# end

json.photos @user.photos do |photo|
  json.extract! photo, :url, :created_at
end

json.posts @user.posts.order("created_at").includes(:photos, :likes, { comments: [:author] }, :author) do |post|

  json.extract! post, :id, :author_id, :body
  json.author_name post.author.name
  json.author_avatar post.author.profile_pic
  json.posted_at post.posted_on

  json.likes post.likes do |like|
    json.extract! like, :id, :liker_id
  end

  like = post.likes.to_a.select! { |like| like.liker_id == current_user.id }.try(:first)
  if like
    json.like do
      json.extract! like, :id
    end
  end

  json.numLikes post.likes.length

  json.comments post.comments.order("updated_at") do |comment|
    json.extract! comment, :id, :author_id, :body
    json.author_name comment.author.name
    json.author_avatar comment.author.profile_pic
    json.commented_on comment.commented_on
  end

  json.photos post.photos do |photo|
    json.extract! photo, :id, :url
  end
end
