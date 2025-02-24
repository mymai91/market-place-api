class User < ApplicationRecord
  # handles password hashing and salting
  has_secure_password
  
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, length: { minimum: 6 }

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
end