class Comment < ActiveRecord::Base

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
end
