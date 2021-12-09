class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*\z/i
  validates :username, presence: true, length: { minimum: 2, maximum: 50 },
            format: {with: VALID_USERNAME_REGEX}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  VALID_PHONE_REGEX = /\A[+]?[0-9]*\z/i
  validates :phone, presence: true, length: { minimum: 9, maximum: 16},
            format: {with: VALID_PHONE_REGEX},
            uniqueness: true

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

end
