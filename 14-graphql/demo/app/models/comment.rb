class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post

  validates :author, presence: true
  validates :post, presence: true
  validates :body, presence: true
end
