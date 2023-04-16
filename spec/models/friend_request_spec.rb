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

    it "sender and receiver can't be the same" do
      request = described_class.new(sender_id: sender.id, receiver_id: sender.id)
      expect(request).not_to be_valid
    end

    it "is valid when sender and receiver are different" do
      request = described_class.new(sender_id: sender.id, receiver_id: receiver.id)
      expect(request).to be_valid
    end
  end
end
