class Post < ActiveRecord::Base

  validates :author_id, :body, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id

  has_many :photos,
    class_name: "Photo",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post

  has_many :likes,
    class_name: "Like",
    foreign_key: :post_id,
    primary_key: :id

  has_many :mentions,
    class_name: "Mention",
    foreign_key: :post_id,
    primary_key: :id

  has_many :comments, -> { order(:updated_at => :asc) }

  has_many :likers,
    through: :likes,
    source: :liker

  def posted_on
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
