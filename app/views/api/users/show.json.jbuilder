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
end
