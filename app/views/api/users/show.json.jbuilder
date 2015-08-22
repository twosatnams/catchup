json.extract! @user,
  :id,
  :name,
  :dob,
  :profile_pic,
  :cover_pic,
  :city,
  :school,
  :workplace

if current_user.friends.pluck(:id).include?(@user.id)
  json.friendship_status "un-friend"

  friendshipID = Friend.where(
    '(user_id = :id AND friend_id = :friend_id) OR
      user_id = :friend_id AND friend_id = :id',
     id: current_user.id, friend_id: @user.id
  ).pluck(:id).join("").to_i

  json.friendshipID friendshipID

elsif current_user.unsuccessful_requests.pluck(:friend_id).include?(@user.id)
  json.friendship_status "friend-request-sent"
elsif current_user.friend_requests.pluck(:user_id).include?(@user.id)
  json.friendship_status "accept-friend-request"

  friendshipID = Friend.where(
    '(user_id = :id AND friend_id = :friend_id) OR
      user_id = :friend_id AND friend_id = :id',
     id: current_user.id, friend_id: @user.id
  ).pluck(:id).join("").to_i

  json.friendshipID friendshipID

elsif current_user == @user
  json.friendship_status "user-himself"
else
  json.friendship_status "add-friend"
end

json.friends @user.friends do |friend|
  json.extract! friend, :id, :name
end

json.unsuccessful_requests @user.unsuccessful_requests do |friendship|
  json.extract! friendship, :id, :friend_id
  json.name User.find(friendship.friend_id).name
end

json.friend_requests @user.friend_requests do |friendship|
  json.extract! friendship, :id, :user_id
  json.name User.find(friendship.user_id).name
end

if current_user.id != @user.id
  mutual_friends = []
  current_user.friends.each do |friend|
    if @user.friends.include?(friend)
      mutual_friends << friend
    end
  end
  json.mutual_friends mutual_friends do |friend|
    json.extract! friend, :name
  end
end

json.posts @user.posts.order("created_at").includes(:photos, :likes, :comments, :author) do |post|

  json.extract! post, :id, :author_id, :body
  json.author_name post.author.name
  json.author_avatar post.author.profile_pic
  json.posted_at post.post_date

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

  json.comments post.comments do |comment|
    json.extract! comment, :id, :author_id, :body, :created_at
    json.author_name comment.author.name
    json.author_avatar comment.author.profile_pic
  end

  json.photos post.photos do |photo|
    json.extract! photo, :id, :url
  end
end
