class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @friend_request = FriendRequest.mutual(current_user, @user).first || FriendRequest.new

    if @user != current_user && @friend_request.created_at
      mark_notifications_as_read(@friend_request.notifications_as_friend_request.where(recipient: current_user))
    end
  end

  def friends
    @user = User.find_by_id(params[:id])
    @friends = User.friends(@user)
  end
end
