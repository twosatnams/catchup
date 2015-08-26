suckr = ImageSuckr::GoogleSuckr.new
created_users = 10
generated_users = 490
user_count = 0
post_count = 0
comment_count = 0
likes_count = 0
friendships_count = 0
photos_count = 0
user_range = (1..(generated_users + created_users)).to_a
# user_range = (1..generated_users).to_a


# Users
User.create!([
  {name: "Bruce Wayne", email: "bruce@gotham.com", dob: "1990-12-24", password: "qwerty", profile_pic: "http://vignette2.wikia.nocookie.net/thedarkknighttrilogy/images/9/96/Bruce_Wayne.jpg/revision/latest?cb=20130114180415", city: "Gotham, New Jersey", school: "Gotham State", workplace: "Wayne Enterprises"},
  {name: "Megan Fox", email: "megan@gotham.com", dob: "1986-05-06", password: "qwerty", profile_pic: "http://res.cloudinary.com/satnam14/image/upload/v1440309181/lsymzbqhtdhckmqlc5rv.jpg", city: "Los Angeles, California", school: "St. Lucie West Centennial High School", workplace: "Hollywood"},
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
    "California Institute of Technology",
    "University College London",
    "University of California, Berkeley",
    "University of Oxford",
    "University of California, Los Angeles",
    "Imperial College London",
    "University of California, San Diego",
    "ETH Zurich",
    "Queen Mary University of London",
    "Cornell University",
    "University of Michigan",
    "University of Texas at Austin"
  ]
  user[:school] = university.sample
  user[:workplace] = Faker::Company.name
  successful = User.create!([user])
  user_count += 1 if successful
  puts user_count
end

# Posts
user_range.each do |user|
  (5..8).to_a.sample.times do
    post = {}
    post[:author_id] = user
    post[:body] = Faker::Lorem.paragraph((2..5).to_a.sample)
    successful = Post.create!([post])
    post_count += 1 if successful
    puts post_count
  end
end

# Comments
(post_count + 1).times do |post|
  (1..8).to_a.sample.times do |comment|
    comment = {}
    comment[:body] = Faker::Lorem.sentence
    comment[:post_id] = post
    comment[:author_id] = user_range.sample
    successful = Comment.create!([comment])
    comment_count += 1 if successful
    puts comment_count
  end
end

# Likes
user_range.each do |user|
  (post_count/10).times do
    like = {}
    like[:liker_id] = user
    like[:post_id] = (1..425).to_a.sample
    successful = Like.create([like])
    likes_count += 1 if successful
    puts likes_count
  end
end


# Photos
(post_count + 1).times do |post|
  (0..3).to_a.sample.times do |number_photos|
    photo = {}
    photo[:url] = suckr.get_image_url
    photo[:post_id] = post
    next if photo[:url] == ""
    successful = Photo.create([photo])
    photos_count += 1 if successful
    puts photos_count
  end
end

#Friends
user_range.each do |user|
  (50..150).to_a.sample.times do
    friend = {}
    friend[:user_id] = user
    friend[:friend_id] = user_range.sample
    friend[:pending] = [true, false].sample
    successful = Friend.create([friend])
    friendships_count += 1 if successful
    puts friendships_count
  end
end


# Friend.create!({:user_id => 1, :friend_id => 5, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 6, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 7, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 8, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 9, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 10, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 11, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 12, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 13, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 14, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 15, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 16, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 17, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 18, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 19, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 20, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 21, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 22, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 23, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 24, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 25, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 26, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 27, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 28, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 29, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 30, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 31, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 32, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 33, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 34, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 35, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 36, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 37, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 38, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 39, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 40, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 41, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 42, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 43, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 44, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 45, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 46, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 47, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 48, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 49, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 50, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 51, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 52, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 53, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 54, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 55, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 56, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 57, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 58, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 59, :pending => false})
# Friend.create!({:user_id => 1, :friend_id => 60, :pending => false})
#
# # Friends of Megan
# Friend.create!({:user_id => 2, :friend_id => 1, :pending => true})
# Friend.create!({:user_id => 2, :friend_id => 5, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 6, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 7, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 8, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 9, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 10, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 11, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 12, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 13, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 14, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 15, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 16, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 17, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 18, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 19, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 20, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 21, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 22, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 23, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 24, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 25, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 26, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 27, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 28, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 29, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 30, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 31, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 32, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 33, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 34, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 35, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 36, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 37, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 38, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 39, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 40, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 41, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 42, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 43, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 44, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 45, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 46, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 47, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 48, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 49, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 50, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 51, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 52, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 53, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 54, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 55, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 56, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 57, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 58, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 59, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 60, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 61, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 62, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 63, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 64, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 65, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 66, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 67, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 68, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 69, :pending => false})
# Friend.create!({:user_id => 2, :friend_id => 70, :pending => false})
#
# # Friends of Mark
# Friend.create!({:user_id => 3, :friend_id => 1, :pending => true})
# Friend.create!({:user_id => 3, :friend_id => 2, :pending => true})
# Friend.create!({:user_id => 3, :friend_id => 5, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 6, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 7, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 8, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 9, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 10, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 11, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 12, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 13, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 14, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 15, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 16, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 17, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 18, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 19, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 20, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 21, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 22, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 23, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 24, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 25, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 26, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 27, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 28, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 29, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 30, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 31, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 32, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 33, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 34, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 35, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 36, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 37, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 38, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 39, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 40, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 41, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 42, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 43, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 44, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 45, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 46, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 47, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 48, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 49, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 50, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 51, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 52, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 53, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 54, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 55, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 56, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 57, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 58, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 59, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 60, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 61, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 62, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 63, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 64, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 65, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 66, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 67, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 68, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 69, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 70, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 71, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 72, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 73, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 74, :pending => false})
# Friend.create!({:user_id => 3, :friend_id => 75, :pending => false})
#
# # Friends of Ronda
# Friend.create!({:user_id => 4, :friend_id => 1, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 2, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 3, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 5, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 6, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 7, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 8, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 9, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 10, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 11, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 12, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 13, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 14, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 15, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 16, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 17, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 18, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 19, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 20, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 21, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 22, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 23, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 24, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 25, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 26, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 27, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 28, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 29, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 30, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 31, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 32, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 33, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 34, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 35, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 36, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 37, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 38, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 39, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 40, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 41, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 42, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 43, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 44, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 45, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 46, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 47, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 48, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 49, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 50, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 51, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 52, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 53, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 54, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 55, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 56, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 57, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 58, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 59, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 60, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 61, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 62, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 63, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 64, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 65, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 66, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 67, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 68, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 69, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 70, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 71, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 72, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 73, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 74, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 75, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 76, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 77, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 78, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 79, :pending => false})
# Friend.create!({:user_id => 4, :friend_id => 80, :pending => false})
