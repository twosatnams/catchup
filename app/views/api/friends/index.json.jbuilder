json.array! @friendships do |friendship|
  json.extract! friendship, :name, :profile_pic
end
