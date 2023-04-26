class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender_id, :receiver_id,
            presence: true,
            unique_friend_request: true, on: :create

  validates :sender_id, comparison: { other_than: :receiver_id }
end
