json.extract! @user,
  :id,
  :name,
  :dob,
  :profile_pic,
  :cover_pic,
  :city,
  :school,
  :workplace

json.posts @user.posts do |post|
  json.extract! post, :id, :author_id, :body

  json.likes post.likes do |like|
    json.extract! like, :id, :liker_id
  end

  json.comments post.comments do |comment|
    json.extract! comment, :id, :author_id, :body
  end

  json.photos post.photos do |photo|
    json.extract! photo, :id, :url
  end
end
