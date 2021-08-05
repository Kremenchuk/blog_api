class User < ApplicationRecord
  has_secure_password


  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: {minimum: 6}

  has_many :articles
  has_many :comments
end
