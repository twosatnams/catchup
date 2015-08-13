class Mention < ActiveRecord::Base

  validates :mentioned_user_id, :post_id, presence: true

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id

  belongs_to :mentioned_user,
    class_name: "User",
    foreign_key: :mentioned_user_id,
    primary_key: :id
end
