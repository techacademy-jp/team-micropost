class User < ApplicationRecord
  # メールアドレスを永続化前に全て小文字に変換する
  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # rails標準機能
  has_secure_password
  
  has_many :microposts
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # お気に入りのリレーション
  has_many :favorite, foreign_key: :user_id
  has_many :micropost, through: :favorite
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def get_favorite_list_from_microposts(microposts)
    microposts_ids = []
    
    microposts.each do |mpost|
      microposts_ids.push(mpost[:id])
    end
    
    flist = Favorite.where(content_id: microposts_ids, user_id: self.id)
    
    fhash = {}
    flist.each do |fv|
      fhash[fv.content_id] = fv
    end
    return fhash
  end
end
