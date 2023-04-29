class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]

  def index
    @friend_requests = FriendRequest.all
  end

  def create
    @friend_request = FriendRequest.create(friend_request_params)
  end

  def update
    @friend_request.update(accepted: true)
  end

  def destroy
    @friend_request.destroy
  end

  private

    def set_friend_request
      @friend_request = FriendRequest.find_by_id(params[:id])
    end

    def friend_request_params
      params.require(:friend_request).permit(:sender_id, :receiver_id)
    end
end
