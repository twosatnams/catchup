class User < ActiveRecord::Base
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 5, allow_nil: true }
  validates :email, uniqueness: true

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id

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

  protected

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def blank_profile_pics
    self.profile_pic = "assets/profile/avatar.png"
    self.cover_pic = "assets/profile/cover.jpg"
  end
end
