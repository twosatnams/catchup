json.array! @users do |user|
  json.extract! user, :name, :profile_pic, :city
end
