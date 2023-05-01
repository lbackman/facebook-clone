class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Friendships as sender
  has_many :sent_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :sender_id,
           dependent: :destroy

  has_many :friendships_as_sender,
           -> { where("accepted = ?", true) },
           class_name: "FriendRequest",
           foreign_key: :sender_id
      
  has_many :sent_friends,
           through: :friendships_as_sender,
           source: :receiver

  # Friendships as receiver
  has_many :received_friend_requests,
           class_name: "FriendRequest",
           foreign_key: :receiver_id,
           dependent: :destroy       

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

  def friends_with?(other_user)
    FriendRequest.exists?(
      sender_id:   [self.id, other_user.id],
      receiver_id: [other_user.id, self.id],
      accepted:    true
    )
  end

  def sent_friend_request_to?(other_user)
    FriendRequest.exists?(
      sender_id:   self.id,
      receiver_id: other_user.id,
      accepted:    false
    )
  end

  def received_friend_request_from?(other_user)
    FriendRequest.exists?(
      sender_id:   other_user.id,
      receiver_id: self.id,
      accepted:    false
    )
  end
end
