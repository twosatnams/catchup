json.extract! @user,
  :id,
  :name,
  :dob,
  :profile_pic,
  :cover_pic,
  :city,
  :school,
  :workplace

json.friends @user.friends do |friend|
  json.extract! friend, :id, :name
end

json.unsuccessful_friend_requests @user.unsuccessful_friend_requests do |friendship|
  json.extract! friendship, :id, :friend_id
end

json.friend_requests @user.friend_requests do |friendship|
  json.extract! friendship, :id, :user_id
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
