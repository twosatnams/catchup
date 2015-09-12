class FriendRequest < ActiveRecord::Base
  validates :user_id, :friend_id, presence: true
  validates_uniqueness_of :user_id, :scope => :friend_id
  validate :user_and_friend_are_different

  def user_and_friend_are_different
    if self.user_id == self.friend_id
      errors.add(:user_id, "must be different to #{friend_id}")
    end
  end

  belongs_to :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :friend,
    class_name: "User",
    foreign_key: :friend_id,
    primary_key: :id
end
