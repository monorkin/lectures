class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy

  validates :author, presence: true
  validates :title, presence: true
  validates :body, presence: true

  def comment_count
    @comment_count ||= comments.count
  end
end
