class Member < ApplicationRecord
  has_secure_password
  belongs_to :organization
  has_many :posts, dependent: :destroy
end
