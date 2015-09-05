require 'byebug'
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

  def friend_requests
    friend_ids = Friend.where(
      'friend_id = ? AND pending = true', self.id
      ).all
  end

  def unsuccessful_requests
    friend_ids = Friend.where(
      'user_id = ? AND pending = true', self.id
      ).all
  end

  def born_on
    unformatted = self.dob
    year = unformatted.strftime('%Y')
    month = unformatted.strftime('%B')
    date = unformatted.strftime('%d')
    "#{month} #{date}, #{year}"
  end

  def friends
    user_ids = Friend.where(
      '(user_id = :id OR friend_id = :id) AND pending = false',
       id: self.id
    ).pluck(:user_id, :friend_id)
     .flatten
     .uniq
     .reject { |id| id == self.id }

    users = User.where(id: user_ids)
  end

  def self.sort_by_university(results, seeker)
    preresults = results.dup
    users_with_same_uni = []

    results.each do |user|
      if user.school == seeker.school
        users_with_same_uni << user
        preresults.delete(user)
      end
    end

    users_with_same_uni.concat(preresults)
  end

  def self.sort_by_state(results, seeker)
    users_with_same_state = []
    results.each do |user|
      if user.city.split(",").last == seeker.city.split(",").last
        users_with_same_state << user
        results.delete(user)
      end
    end

    users_with_same_state.concat(results)
  end

  def self.sort_by_city(results, seeker)
    users_with_same_city = []
    results.each do |user|
      if user.city.split(",").first == seeker.city.split(",").first
        users_with_same_city << user
        results.delete(user)
      end
    end

    users_with_same_city.concat(results)
  end

  def self.search(search, seeker)
    return [] if search == ""
    query = search.downcase

    results = User.where("name ~* ?", "^#{query}[a-z]*|[a-z]* #{query}")
    # results.to_a.sort_by! { |user| (self.dob - user.dob).abs }

    sort_state = sort_by_state(results, seeker)
    sort_city = sort_by_city(sort_state, seeker)
    sort_univ = sort_by_university(sort_city, seeker)

    return sort_univ.take(8)

  end

  def num_friends
    Rails.cache.fetch("num_friends") do
      friends.length
    end
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
