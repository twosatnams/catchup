class Post < ActiveRecord::Base

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id

  has_many :photos,
    class_name: "Photo",
    foreign_key: :post_id,
    primary_key: :id

  has_many :likes,
    class_name: "Like",
    foreign_key: :post_id,
    primary_key: :id

  has_many :mentions,
    class_name: "Mention",
    foreign_key: :post_id,
    primary_key: :id

  has_many :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id

end
