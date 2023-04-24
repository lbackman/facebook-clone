class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
  end

  def show
    @friend_request = FriendRequest.find_by_id(params[:id])
  end

  def update
    @friend_request = FriendRequest.find_by_id(params[:id])
  end

  def destroy
  end
end
