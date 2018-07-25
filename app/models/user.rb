class User < ApplicationRecord
  # メールアドレスを永続化前に全て小文字に変換する
  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # rails標準機能
  has_secure_password
end
