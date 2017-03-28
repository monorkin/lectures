class Author < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  def full_name
    [first_name.presence, last_name.presence].compact.join(' ')
  end

  def password
    ''
  end

  def password=(password)
    self.password_digest = Digest::SHA256.base64digest(password)
  end
end
