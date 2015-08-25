# Users

User.create!([
  {name: "Bruce Wayne", email: "bruce@gotham.com", dob: "1-1-1975", password: "qwerty", profile_pic: "http://vignette2.wikia.nocookie.net/thedarkknighttrilogy/images/9/96/Bruce_Wayne.jpg/revision/latest?cb=20130114180415", city: "San Francisco, California", school: "Stanford", workplace: "Wayne Enterprises"},
  {name: "Megan Fox", email: "megan@gotham.com", dob: "2-5-1986", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440309181/lsymzbqhtdhckmqlc5rv.jpg", city: "LA, California", school: "UC Irvine", workplace: "Hollywood"},
  {name: "Mark Zuckerberg", email: "mark@gotham.com", dob: "4-8-1988", password: "qwerty", profile_pic: "http://images.askmen.com/photos/mark-zuckerberg/86153.jpg", city: "Menlo Park, California", school: "Harvard", workplace: "Facebook"},
  {name: "Rhonda Rousey", email: "ronda@gotham.com", dob: "7-3-1984", password: "qwerty", profile_pic: "http://www.mmaoddsbreaker.com/wp-content/uploads/2013/02/ronda-rousey.jpeg", city: "LA, California", school: "UC Santa Barbara", workplace: "UFC"},
  {name: "Giroud", email: "giroud@gotham.com", dob: "2015-08-01", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440309584/jl0haict7yat2dekva2o.jpg", cover_pic: "/assets/cover.jpg", city: "London", school: "UC Davis", workplace: "Arsenal FC"},
  {name: "Cristiano Ronaldo", email: "ronaldo@gotham.com", dob: "2015-08-15", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440310185/sgvwypu1yzpmuf2mtkuv.jpg", cover_pic: "/assets/cover.jpg", city: "Madrid", school: "Emirates Stadium", workplace: "Real Madrid FC"},
  {name: "Katrina Kaif", email: "katrina@gotham.com", dob: "2015-08-05", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440310318/vl2mfvwtxg5mtqe2d79w.jpg", cover_pic: "/assets/cover.jpg", city: "Mumbai", school: "Delhi Public School", workplace: "Bollywood"}
])

suckr = ImageSuckr::GoogleSuckr.new

80.times do |user|
  user = {}
  user[:name] = Faker::Name.name
  user[:email] = Faker::Internet.email
  year = (1930..2015).to_a.sample
  month = (1..12).to_a.sample
  day =  (1..28).to_a.sample
  user[:dob] = "#{year}-#{month}-#{day}"

  user[:profile_pic] = suckr.get_image_url({"q" => "profile picture"})

  user[:password] = "qwerty"
  user[:city] = "#{Faker::Address.city}, #{Faker::Address.state}"
  university = [
    "Princeton University",
    "Harvard University",
    "Yale University",
    "Columbia University",
    "Stanford University",
    "University of Chicago",
    "Massachusetts Institute of Technology",
    "Duke University",
    "University of Pennsylvania",
    "California Institute of Technology"
  ]
  user[:school] = university.sample
  user[:workplace] = Faker::Company.name
  User.create!([user])
end

# Posts
(1..85).each do |user|
  5.times do
    post = {}
    post[:author_id] = user
    post[:body] = Faker::Lorem.paragraph(2)
    Post.create!([post])
  end
end

# Comments
425.times do |post|
  (1..4).to_a.sample.times do |comment|
    comment = {}
    comment[:body] = Faker::Lorem.sentence
    comment[:post_id] = post
    comment[:author_id] = (1..85).to_a.sample
    Comment.create!([comment])
  end
end

# Likes
85.times do |user|
  20.times do
    like = {}
    like[:liker_id] = user
    like[:post_id] = (1..425).to_a.sample
    Like.create!([like])
  end
end


# Photos
425.times do |post|
  photo = {}
  photo[:url] = suckr.get_image_url
  photo[:post_id] = (1..425).to_a.sample
  next if photo[:url] == ""
  Photo.create([photo])
end

#Friends
# Friends of Bruce Wayne
100000.times do |friendship|
  friend = {}
  friend[:user_id] = (1..87).to_a.sample
  friend[:friend_id] = (1..87).to_a.sample
  friend[:pending] = [true, false].sample
  Friend.create!([friend])
end

#
# Friend.create({:user_id => 1, :friend_id => 5, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 6, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 7, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 8, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 9, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 10, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 11, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 12, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 13, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 14, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 15, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 16, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 17, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 18, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 19, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 20, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 21, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 22, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 23, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 24, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 25, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 26, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 27, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 28, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 29, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 30, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 31, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 32, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 33, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 34, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 35, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 36, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 37, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 38, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 39, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 40, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 41, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 42, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 43, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 44, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 45, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 46, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 47, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 48, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 49, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 50, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 51, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 52, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 53, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 54, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 55, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 56, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 57, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 58, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 59, :pending => false})
# Friend.create({:user_id => 1, :friend_id => 60, :pending => false})
#
# # Friends of Megan
# Friend.create({:user_id => 2, :friend_id => 1, :pending => true})
# Friend.create({:user_id => 2, :friend_id => 5, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 6, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 7, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 8, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 9, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 10, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 11, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 12, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 13, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 14, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 15, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 16, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 17, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 18, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 19, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 20, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 21, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 22, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 23, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 24, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 25, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 26, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 27, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 28, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 29, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 30, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 31, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 32, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 33, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 34, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 35, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 36, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 37, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 38, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 39, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 40, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 41, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 42, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 43, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 44, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 45, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 46, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 47, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 48, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 49, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 50, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 51, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 52, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 53, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 54, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 55, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 56, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 57, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 58, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 59, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 60, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 61, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 62, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 63, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 64, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 65, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 66, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 67, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 68, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 69, :pending => false})
# Friend.create({:user_id => 2, :friend_id => 70, :pending => false})
#
# # Friends of Mark
# Friend.create({:user_id => 3, :friend_id => 1, :pending => true})
# Friend.create({:user_id => 3, :friend_id => 2, :pending => true})
# Friend.create({:user_id => 3, :friend_id => 5, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 6, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 7, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 8, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 9, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 10, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 11, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 12, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 13, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 14, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 15, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 16, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 17, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 18, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 19, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 20, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 21, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 22, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 23, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 24, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 25, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 26, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 27, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 28, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 29, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 30, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 31, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 32, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 33, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 34, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 35, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 36, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 37, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 38, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 39, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 40, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 41, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 42, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 43, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 44, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 45, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 46, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 47, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 48, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 49, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 50, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 51, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 52, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 53, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 54, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 55, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 56, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 57, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 58, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 59, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 60, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 61, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 62, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 63, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 64, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 65, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 66, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 67, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 68, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 69, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 70, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 71, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 72, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 73, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 74, :pending => false})
# Friend.create({:user_id => 3, :friend_id => 75, :pending => false})
#
# # Friends of Ronda
# Friend.create({:user_id => 4, :friend_id => 1, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 2, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 3, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 5, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 6, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 7, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 8, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 9, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 10, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 11, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 12, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 13, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 14, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 15, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 16, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 17, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 18, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 19, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 20, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 21, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 22, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 23, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 24, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 25, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 26, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 27, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 28, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 29, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 30, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 31, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 32, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 33, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 34, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 35, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 36, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 37, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 38, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 39, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 40, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 41, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 42, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 43, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 44, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 45, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 46, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 47, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 48, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 49, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 50, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 51, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 52, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 53, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 54, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 55, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 56, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 57, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 58, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 59, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 60, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 61, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 62, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 63, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 64, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 65, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 66, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 67, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 68, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 69, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 70, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 71, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 72, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 73, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 74, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 75, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 76, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 77, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 78, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 79, :pending => false})
# Friend.create({:user_id => 4, :friend_id => 80, :pending => false})
