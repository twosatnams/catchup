require_relative 'photo_urls'
require_relative 'profile_urls'
require_relative 'cities'
require_relative 'universities'
require_relative 'family_names'
require_relative 'male_first_names'
require_relative 'female_first_names'

created_users = 10
generated_users = 99
user_count = 0
post_count = 0
comment_count = 0
likes_count = 0
friendships_count = 0
photos_count = 0
user_range = (1..(generated_users + created_users)).to_a


# Users
User.create!([
  {name: "Bruce Wayne", email: "bruce@gotham.com", dob: "1990-12-24", password: "qwerty", profile_pic: "http://vignette2.wikia.nocookie.net/thedarkknighttrilogy/images/9/96/Bruce_Wayne.jpg/revision/latest?cb=20130114180415", city: "Gotham, New Jersey", school: "Stanford University", workplace: "Wayne Enterprises"},
  {name: "Megan Fox", email: "megan@gotham.com", dob: "1986-05-06", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440309181/lsymzbqhtdhckmqlc5rv.jpg", city: "Los Angeles, California", school: "University of California, Los Angeles", workplace: "Hollywood"},
  {name: "Mark Zuckerberg", email: "mark@gotham.com", dob: "1984-05-14", password: "qwerty", profile_pic: "http://images.askmen.com/photos/mark-zuckerberg/86153.jpg", city: "Menlo Park, California", school: "Harvard University", workplace: "Facebook"},
  {name: "Rhonda Rousey", email: "ronda@gotham.com", dob: "1987-02-01", password: "qwerty", profile_pic: "http://www.mmaoddsbreaker.com/wp-content/uploads/2013/02/ronda-rousey.jpeg", city: "Venice, California", school: "Hayastan MMA Academy", workplace: "Ultimate Fighting Championship"},
  {name: "Tyler Durden", email: "tyler@gotham.com", dob: "1975-08-01", password: "qwerty", profile_pic: "https://daleylife.files.wordpress.com/2013/07/tumblr_mqckwkatmg1st51fio4_500.jpg", cover_pic: "/assets/cover.jpg", city: "Chicago, Illinois", school: "Homeschooled", workplace: "Self-Employed"},
  {name: "Cristiano Ronaldo", email: "ronaldo@gotham.com", dob: "1985-02-05", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440310185/sgvwypu1yzpmuf2mtkuv.jpg", cover_pic: "/assets/cover.jpg", city: "Madrid, Spain", school: "Academia Sporting", workplace: "Real Madrid FC"},
  {name: "J. K. Rowling", email: "jk@gotham.com", dob: "1965-07-31", password: "qwerty", profile_pic: "http://a4.files.biography.com/image/upload/c_fill,cs_srgb,dpr_1.0,g_face,h_300,q_80,w_300/MTE1ODA0OTcxMzcxNTYyNTA5.jpg", cover_pic: "/assets/cover.jpg", city: "London, United Kingdom", school: "University of Exeter", workplace: "Self-Employed"},
  {name: "Lionel Messi", email: "messi@gotham.com", dob: "1987-06-24", password: "qwerty", profile_pic: "http://dailymailnews.com/wp-content/uploads/2015/05/messi.jpg", cover_pic: "/assets/cover.jpg", city: "Barcelona, Spain", school: "La Masia", workplace: "FC Barcelona"},
  {name: "Alexis Sanchez", email: "alexis@gotham.com", dob: "1988-12-19", password: "qwerty", profile_pic: "http://static.goal.com/434100/434187_heroa.jpg", cover_pic: "/assets/cover.jpg", city: "London, England", school: "Emirates Stadium", workplace: "Arsenal FC"},
  {name: "Katrina Kaif", email: "katrina@gotham.com", dob: "1983-07-16", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440310318/vl2mfvwtxg5mtqe2d79w.jpg", cover_pic: "/assets/cover.jpg", city: "Mumbai, India", school: "Delhi Public School", workplace: "Bollywood"}
])

generated_users.times do |user|
  user = {}
  gender = ["male", "female"].sample
  if gender == "male"
    name = "#{MaleFirstNames.sample} #{FamilyNames.sample}"
    user[:name] = name
    user[:profile_pic] = MaleProfilePics.sample
  else
    name = "#{FemaleFirstNames.sample} #{FamilyNames.sample}"
    user[:name] = name
    user[:profile_pic] = FemaleProfilePics.sample
  end
  user[:email] = Faker::Internet.email
  year = (1950..2015).to_a.sample
  month = (1..12).to_a.sample
  day =  (1..28).to_a.sample
  user[:dob] = "#{year}-#{month}-#{day}"


  user[:password] = "qwerty"
  user[:city] = Cities.sample
  user[:school] = Universities.sample
  user[:workplace] = Faker::Company.name
  successful = User.create!([user])
  user_count += 1 if successful
  puts "Users created: #{user_count}"
end

# Posts
user_range.each do |user|
  (3..6).to_a.sample.times do
    post = {}
    post[:author_id] = user
    post[:body] = Faker::Lorem.paragraph((2..5).to_a.sample)
    successful = Post.create!([post])
    post_count += 1 if successful
    puts "Posts created: #{post_count}"
  end
end

# Comments
(post_count + 1).times do |post|
  (3..6).to_a.sample.times do |comment|
    comment = {}
    comment[:body] = Faker::Lorem.sentence
    comment[:post_id] = post
    comment[:author_id] = user_range.sample
    successful = Comment.create!([comment])
    comment_count += 1 if successful
    puts "Comments created: #{comment_count}"
  end
end

# Likes
user_range.each do |user|
  (10*post_count/generated_users).times do
    like = {}
    like[:liker_id] = user
    like[:post_id] = (1..post_count).to_a.sample
    successful = Like.create([like])
    likes_count += 1 if successful
    puts "Likes created: #{likes_count}"
  end
end


# Photos
(post_count + 1).times do |post|
  (1..5).to_a.sample.times do |number_photos|
    photo = {}
    photo[:url] = Photos.sample
    photo[:post_id] = post
    next if photo[:url] == ""
    successful = Photo.create([photo])
    photos_count += 1 if successful
    puts "Photos created: #{photos_count}"
  end
end

#Friends
user_range.each do |user|
  (50..120).to_a.sample.times do
    friend = {}
    friend[:user_id] = user
    friend[:friend_id] = user_range.sample
    friend[:pending] = [true, false, false, false, false, false, false, false].sample
    successful = Friend.create([friend])
    friendships_count += 1 if successful
    puts "Friendships created: #{friendships_count}"
  end
end

puts "Users created: #{user_count}"
puts "Posts created: #{post_count}"
puts "Comments created: #{comment_count}"
puts "Likes created: #{likes_count}"
puts "Friendships created: #{friendships_count}"
puts "Photos created: #{photos_count}"
