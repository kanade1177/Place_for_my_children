class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   attachment :profile_image
   has_many :tweets
   has_many :favorites
   has_many :comments
 #元々のやつ
  # 自分がフォローしているユーザーとの関係
   has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
   has_many :followings, through: :active_relationships, source: :follower

  # # 自分がフォローされているユーザーとの関係
   has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
   has_many :followers, through: :passive_relationships, source: :following



   # 自分が作った通知関連
   has_many :active_notifications, class_name: "Notification", foreign_key: :visiter_id, dependent: :destroy
    # 自分宛の通知関連
   has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy

   # 元々のやつ
   def followed_by?(user)
     passive_relationships.find_by(following_id: user.id).present?
   end

   # 試してるやつ ここから
   # def following?(user)
   #   following_relationships.find_by(following_id: user.id)
   # end

   # def follow(user)
   #  following_relationships.create!(following_id: user.id)
   # end

   # def unfollow(user)
   #  following_relationships.find_by(following_id: user.id).destroy
   # end

   # def following?(user)
   #  following_user.include?(user)
   # end
   #ここまで
   
   #お試し２
   


   def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
     notification = current_user.active_notifications.new(
      visited_id: id,
      action: "follow"
      )
      notification.save if notification.valid?
    end
   end






end
