class RemoveIndexOnSenderAndReceiver < ActiveRecord::Migration[7.0]
  def change
    remove_index :friend_requests, column: [:sender_id, :receiver_id]
  end
end
