class Member < ApplicationRecord
  belongs_to :organization
  has_many :posts, dependent: :destroy
end
