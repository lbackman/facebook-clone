class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Friendships

  has_many :sent_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :sender_id

  has_many :friendships_as_sender,
           -> { where("accepted = ?", true) },
           class_name: "FriendRequest",
           foreign_key: :sender_id
      
  has_many :sent_friends,
           through: :friendships_as_sender,
           source: :receiver

  has_many :received_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :receiver_id         

  has_many :friendships_as_receiver,
           -> { where("accepted = ?", true) },
           class_name: "FriendRequest",
           foreign_key: :receiver_id

  has_many :received_friends,
           through: :friendships_as_receiver,
           source: :sender

  def friends
    sent_friends + received_friends
  end
end
