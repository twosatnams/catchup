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
elsif current_user.unsuccessful_requests.pluck(:friend_id).include?(@user.id)
  json.friendship_status "friend-request-sent"
elsif current_user.friend_requests.pluck(:user_id).include?(@user.id)
  json.friendship_status "accept-friend-request"
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

json.posts @user.posts.order("created_at") do |post|
  json.extract! post, :id, :author_id, :body

  json.likes post.likes do |like|
    json.extract! like, :id, :liker_id
  end

  like = post.likes.find_by(liker_id: current_user.id)
  if like
    json.like do
      json.extract! like, :id
    end
  end

  json.numLikes post.likes.count

  json.comments post.comments do |comment|
    json.extract! comment, :id, :author_id, :body
    json.author_name comment.author.name
  end

  json.photos post.photos do |photo|
    json.extract! photo, :id, :url
  end
end
