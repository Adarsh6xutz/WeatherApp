class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
end
