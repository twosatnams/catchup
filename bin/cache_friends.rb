puts "running"
User.all.each do |user|
  temp = user.friend_ids
  p temp
end
