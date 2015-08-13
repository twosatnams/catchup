class Mention < ActiveRecord::Base

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
    
end
