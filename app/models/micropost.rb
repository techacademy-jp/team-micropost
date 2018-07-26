class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorite, foreign_key: :content_id
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
