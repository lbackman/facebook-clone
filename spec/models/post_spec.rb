require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { FactoryBot.create(:user) }
  let(:liker) { FactoryBot.create(:user) }

  context 'liking and unliking a post' do
    before(:each) do
      @post = described_class.create(author: author, body: "test")
      @like = FactoryBot.create(:like, user: liker, likeable: @post)
    end

    it 'liking increases the like count by 1' do
      expect(@post.likes_count).to eq(1)
    end

    it 'unliking decreases the like count by 1' do
      @like.destroy

      expect(@post.likes_count).to eq(0)
    end
  end
end
