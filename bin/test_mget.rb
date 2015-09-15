puts "setting the stage"
User.all.each do |user|
  Rails.cache.write("#{user.id}", user)
end

puts "Lets test Redis without mget"
a = Time.now
names = []
(1..10000).to_a.each do |idx|
  names << Rails.cache.read("#{idx}")
end
puts "Redis without mget took: #{(Time.now - a)*1000}ms"
puts "Was the operation correct? #{User.all.to_a == names}"

puts "Lets see the power of mget"
b = Time.now
babes = []
bames = []
puts "Constructing the string"
(1..10000).to_a.each do |idx|
  babes << idx
end
puts "Getting values"
users = Rails.cache.read_multi(*babes)
users.each do |user|
  bames << user
end
puts "Redis with mget took: #{(Time.now - b)*1000}ms"
puts "Was the operation correct? #{User.all.to_a == names}"
puts "Are the results equivalent? #{names == bames}"
