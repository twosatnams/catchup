puts "Lets test Redis"
User.all.each do |user|
  Rails.cache.write("#{user.id}", user)
end

a = Time.now
names = []
User.all.each do |user|
  person = Rails.cache.read("#{user.id}")
  names << person
end
puts "Redis took: #{(Time.now - a)*1000}ms"

puts "Lets test Ruby"
b = Time.now
babes = []
all_users = User.all
all_users.each do |user|
  babes << user
end
puts "Ruby took: #{(Time.now - b)*1000}ms"
