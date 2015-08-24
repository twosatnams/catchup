json.array! @users do |user|
  json.extract! user, :id, :name, :profile_pic, :city
end
