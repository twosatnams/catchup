class Photo < ActiveRecord::Base
  validates :url, :post_id, presence: true

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    inverse_of: :photos,
    primary_key: :id

end
