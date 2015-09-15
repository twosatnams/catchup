puts "running"
User.all.each do |user|
  Rails.cache.write("#{user.id}.friend_ids", user.friend_ids)
  puts user.id
end
