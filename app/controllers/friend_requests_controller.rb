class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
  end

  def show
    @friend_request = FriendRequest.find_by_id(params[:id])
  end

  def create
    @friend_request = FriendRequest.create(friend_request_params)
  end

  def update
    @friend_request = FriendRequest.find_by_id(params[:id])
    @friend_request.update(accepted: true)
  end

  def destroy
    @friend_request = FriendRequest.find_by_id(params[:id])
    @friend_request.destroy
  end

  private

    def friend_request_params
      params.require(:friend_request).permit(:sender_id, :receiver_id)
    end
end
