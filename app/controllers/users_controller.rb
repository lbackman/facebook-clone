class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @friend_request = FriendRequest.where(
      sender:   [current_user, @user],
      receiver: [current_user, @user]
    ).first || FriendRequest.new
  end

  def friends
    @user = User.find_by_id(params[:id])
    @friends = @user.friends
  end
end
