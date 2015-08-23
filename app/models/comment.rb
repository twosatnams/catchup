class Comment < ActiveRecord::Base
  validates :body, :author_id, :post_id, presence: true

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id

  def commented_on
    unformatted = self.created_at
    year = unformatted.strftime('%Y')
    month = unformatted.strftime('%B')
    date = unformatted.strftime('%d')
    hour = unformatted.strftime('%I')
    minute = unformatted.strftime('%M')
    am = unformatted.strftime('%p')
    "#{month} #{date}, #{year} at #{hour}:#{minute}#{am}"
  end
end
