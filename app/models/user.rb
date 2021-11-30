class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  # following_user:中間テーブルを通してfollowedモデルのフォローされる側を取得すること
  has_many :follower_user, through: :followed, source: :follower
  # follower_user:中間テーブルを通してfollowerモデルのフォローする側を取得すること

# ユーザーをフォローするメソッド
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外すメソッド
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  #フォローの確認を行うメソッド　していればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
