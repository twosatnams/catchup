json.extract! @user,
  :id,
  :name,
  :dob,
  :profile_pic,
  :cover_pic,
  :city,
  :school,
  :workplace

json.posts @user.posts.reverse do |post|
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
