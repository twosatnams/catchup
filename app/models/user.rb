class User < ActiveRecord::Base
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 5, allow_nil: true }
  validates :email, uniqueness: true

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id

  has_many :photos,
    through: :posts,
    source: :photos

  has_many :likes,
    class_name: "Like",
    foreign_key: :liker_id,
    primary_key: :id

  has_many :liked_posts,
    through: :likes,
    source: :post

  has_many :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id

  has_many :friendships,
    class_name: "Friendship",
    foreign_key: :user_id,
    primary_key: :id

  has_many :friends,
    through: :friendships,
    source: :friend

  has_many :friend_requests,
    class_name: "FriendRequest",
    foreign_key: :friend_id,
    primary_key: :id

  has_many :unsuccessful_requests,
    class_name: "FriendRequest",
    foreign_key: :user_id,
    primary_key: :id

  attr_reader :password
  after_initialize :ensure_session_token, :blank_profile_pics

  def self.find_by_credentials(user_params)
    user = User.find_by_email(user_params[:email])
    user.try(:is_password?, user_params[:password]) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  # def friend_requests
  #   friend_ids = Friend.where(
  #     'friend_id = ? AND pending = true', self.id
  #     ).all
  # end
  #
  # def unsuccessful_requests
  #   friend_ids = Friend.where(
  #     'user_id = ? AND pending = true', self.id
  #     ).all
  # end

  def born_on
    unformatted = self.dob
    year = unformatted.strftime('%Y')
    month = unformatted.strftime('%B')
    date = unformatted.strftime('%d')
    "#{month} #{date}, #{year}"
  end

  # def friends
  #   friends = Rails.cache.read("#{self.id}.friends")
  #
  #   if !friends
  #     friends = force_friends
  #     Rails.cache.write("#{self.id}.friends", friends)
  #   end
  #   friends
  # end

  def force_friends
    user_ids = Friend.where(
      '(user_id = :id OR friend_id = :id) AND pending = false',
       id: self.id
    ).pluck(:user_id, :friend_id)
     .flatten
     .uniq
     .reject { |id| id == self.id }

    users = User.where(id: user_ids)
  end

  def friend_ids
    ids = Rails.cache.read("#{self.id}.friend_ids")

    if !ids
      ids = force_friend_ids
      Rails.cache.write("#{self.id}.friend_ids", ids)
    end
    ids
  end

  def force_friend_ids
    Friend.where(
      '(user_id = :id OR friend_id = :id) AND pending = false',
       id: self.id
    ).pluck(:user_id, :friend_id)
     .flatten
     .uniq
     .reject { |id| id == self.id }
  end

  def mutual_friend_ids
    friend_ids = Friend.where(
      '(user_id = :id OR friend_id = :id) AND pending = false',
       id: self.id
      ).all
  end

  def self.rank_by_university!(results, seeker)
    same_uni_score = 50
    results.each do |user, rank|
      if user.school == seeker.school
        results[user][0] += same_uni_score
        results[user][1] = "#{user.school}"
      end
    end
  end

  def self.rank_by_state!(results, seeker)
    same_state_score = 5
    results.each do |user, rank|
      if user.city.split(",").last == seeker.city.split(",").last
        results[user][0] += same_state_score
      end
    end
  end

  def exp
    a = Time.now
    num_comments = 0
    friends = self.friends
    friends.each do |friend|
      comments = friend.comments
      comments.each do |comment|
        num_comments += 1
      end
    end
    puts num_comments
    puts "Time taken: #{(Time.now - a)*1000}"
  end

  def exp2
    a = Time.now
    num_comments = 0
    friends = self.friends.includes(:comments)
    friends.each do |friend|
      comments = friend.comments
      comments.each do |comment|
        num_comments += 1
      end
    end
    puts num_comments
    puts "Time Taken: #{(Time.now - a)*1000.0}"
  end

  # def method_sss
  #   select
  #     u.name,
  #     count(mutual.shared_friend_id) over (partition by u.id) as num_shared
  #   from
  #     users u
  #     left join (
  #         select
  #           f1.friend_id as shared_friend_id,
  #           f2.friend_id as friend_id
  #         from friends f1
  #           join friends f2
  #             on f1.friend_id = f2.user_id
  #         where f1.user_id = 1
  #           and f2.friend_id != f1.user_id
  #       ) mutual
  #       on u.id = mutual.friend_id
  #   where u.name like 'C%'
  #   order by count(mutual.shared_friend_id) over (partition by u.id) desc
  # end

  def self.rank_by_city!(results, seeker)
    same_city_score = 10
    results.each do |user, rank|
      if user.city.split(",").first == seeker.city.split(",").first
        results[user][0] += same_city_score
      end
    end
  end

  def self.rank_by_friends_second!(results, seeker)
    friend_score = 2
    seeker_friends = seeker.friend_ids
    ttb_mutual_function = 0
    ttb_getting_friends = 0

    results.each do |user, rank|
      before_getting_friends = Time.now
      user_friends = user.friend_ids
      after_getting_friends = Time.now
      ttb_getting_friends += (after_getting_friends - before_getting_friends)

      before_mutual = Time.now
      num_mutual_friends = mutual_friends(seeker_friends, user_friends)
      after_mutual = Time.now
      ttb_mutual_function += (after_mutual - before_mutual)

      if num_mutual_friends > 0
        current_score = results[user][0]
        add_score = friend_score*num_mutual_friends
        dominating = add_score > current_score ? true : false

        results[user][0] += add_score
        if dominating
          if num_mutual_friends == 1
            results[user][1] = "1 mutual friend"
          else
            results[user][1] = "#{num_mutual_friends} mutual friends"
          end
        end
      end
    end
    puts "Inside rank by friends function"
    puts "Time spent in querying for friends - #{(100*ttb_getting_friends/(ttb_mutual_function + ttb_getting_friends)).floor}%"
    puts "Time spent in mutual friends function - #{(100*ttb_mutual_function/(ttb_mutual_function + ttb_getting_friends)).floor}%"
  end

  def self.rank_by_friends!(results, seeker)
    friend_score = 2
    seeker_friends = seeker.friend_ids
    ttb_mutual_function = 0
    ttb_getting_friends = 0

    results.each do |user, rank|
      before_getting_friends = Time.now
      user_friends = user.friend_ids
      after_getting_friends = Time.now
      ttb_getting_friends += (after_getting_friends - before_getting_friends)

      before_mutual = Time.now
      num_mutual_friends = mutual_friends(seeker_friends, user_friends)
      after_mutual = Time.now
      ttb_mutual_function += (after_mutual - before_mutual)
      if num_mutual_friends > 0
        current_score = results[user][0]
        add_score = friend_score*num_mutual_friends
        dominating = add_score > current_score ? true : false

        results[user][0] += add_score
        if dominating
          if num_mutual_friends == 1
            results[user][1] = "1 mutual friend"
          else
            results[user][1] = "#{num_mutual_friends} mutual friends"
          end
        end
      end
    end
    puts "Inside rank by friends function"
    puts "Time spent in querying for friends - #{(100*ttb_getting_friends/(ttb_mutual_function + ttb_getting_friends)).floor}%"
    puts "Time spent in mutual friends function - #{(100*ttb_mutual_function/(ttb_mutual_function + ttb_getting_friends)).floor}%"
  end

  def self.mutual_friends(friends_first, friends_second)
    common_friends = friends_first&friends_second
    common_friends.length
  end

  def self.print_search_results(results)
    results.each do |user, rank_array|
      puts "#{user.name}: #{rank_array.first} - #{rank_array.second}"
    end
  end

  def self.search(search, seeker)
    return [] if search == ""
    query = search.downcase
    a = Time.now

    results = User.where("name ~* ?", "^#{query}[a-z]*|[a-z]* #{query}")
    b = Time.now
    # results.to_a.sort_by! { |user| (self.dob - user.dob).abs }

    ranked = {}
    results.each { |user| ranked[user] = [0, "user.city"] }
    c = Time.now

    rank_by_state!(ranked, seeker)
    rank_by_city!(ranked, seeker)
    rank_by_university!(ranked, seeker)
    d = Time.now
    rank_by_friends_second!(ranked, seeker)
    e = Time.now

    # print_search_results(ranked)
    # puts "Time for searching by name - #{b - a}"
    # puts "Time for creating the hash - #{c - b}"
    # puts "Time for ranking results - #{d - c}"
    # puts "Time for ranking friends - #{e - d}"
    total_time_taken = (b - a) + (c - b) + (d - c) + (e - d)
    puts "total time taken by query: #{(total_time_taken)*1000}ms"
    puts "For searching by name: #{(100*(b - a)/total_time_taken).floor}%"
    puts "For creating the hash: #{(100*(c - b)/total_time_taken).floor}%"
    puts "For ranking results except friends: #{(100*(d - c)/total_time_taken).floor}%"
    puts "For ranking by friends: #{(100*(e - d)/total_time_taken).floor}%"

    return ranked.sort_by{ |k,v| v.first }.reverse.take(8)
  end

  protected

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def blank_profile_pics
    self.profile_pic ||= "/assets/avatar.png"
    self.cover_pic ||= "/assets/cover.jpg"
  end
end

# select *
# from (
#     select
#       u.name,
#       count(mutual.shared_friend_id) over (partition by u.id) as num_shared,
#       row_number() over (partition by u.id) as copy_num
#     from
#       users u
#       left join (
#           select
#             f1.friend_id as shared_friend_id,
#             f2.friend_id as friend_id
#           from friends f1
#             join friends f2
#               on f1.friend_id = f2.user_id
#           where f1.user_id = 1
#             and f2.friend_id != f1.user_id
#         ) mutual
#         on u.id = mutual.friend_id
#     where u.name like 'S%'
#   ) all_rows
# where copy_num = 1
# order by num_shared desc
