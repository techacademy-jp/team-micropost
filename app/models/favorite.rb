class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :micropost, foreign_key: :content_id
end
