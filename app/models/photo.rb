class Photo < ActiveRecord::Base
  validates :url, :post_id, presence: true

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id

end
