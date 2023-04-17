require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  # Unnecessary tests: https://www.codewithjason.com/examples-pointless-rspec-tests/
  # Thus commented out
  # describe "Associations" do
  #   it { should belong_to(:sender) }
  #   it { should belong_to(:receiver) }
  # end

  describe "Validations" do
    let(:sender)   { create(:user) }
    let(:receiver) { create(:user) }

    context "Sender and receiver are not the same" do
      it "is invalid when sender and receiver are the same" do
        request = described_class.new(sender_id: sender.id, receiver_id: sender.id)
        expect(request).not_to be_valid
      end

      it "is valid when sender and receiver are different" do
        request = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
        expect(request).to be_valid
      end
    end

    context "Can't send multiple requests to same user" do
      # before(:each) do
      #   @first = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
      # end

      # it "can't send a new request when a previous request is pending" do
      #   second = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
      #   expect(second).not_to be_valid
      # end

      # it "can't send a new request when a previous request is accepted" do
      #   @first.accepted = true
      #   second = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
      #   expect(second).not_to be_valid
      # end

      # it "CAN send a new request when a previous request is declined" do
      #   @first.accepted = false
      #   second = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
      #   expect(second).to be_valid
      # end
    end
  end
end

# Change 'accepted' column default to false, and create index on sender and receiver id.
# Prevent the creation of a new friend request with the same two user_ids.
# 
# Delete the friend request from the database if it is rejected.
# The friend request should also be deleted from the DB if one unfriends the other,
# otherwise a new friend request couldn't be sent.
# 
# The the below should be enough to prevent sending multiple requests to the same user
# validates_uniqueness_of :sender_id, scope: :receiver_id

# https://apidock.com/rails/ActiveRecord/Validations/ClassMethods/validates_uniqueness_of
# https://guides.rubyonrails.org/active_record_validations.html#uniqueness
