require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  # Unnecessary tests: https://www.codewithjason.com/examples-pointless-rspec-tests/
  # Thus commented out
  # describe "Associations" do
  #   it { should belong_to(:sender) }
  #   it { should belong_to(:receiver) }
  # end

  describe "Validations" do
    it "sender and receiver can't be the same" do
      sender = User.create(email: "test@test.com", password: "pass123")
      request = described_class.new(sender_id: sender.id, receiver_id: sender.id)
      expect(request).not_to be_valid
    end
  end
end
