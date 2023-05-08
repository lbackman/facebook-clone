class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]
  before_action :set_user, only: :index

  def index
    @sent_friend_requests = FriendRequest.sent(@user)
    @received_friend_requests = FriendRequest.received(@user)
  end

  def create
    @friend_request = FriendRequest.create(friend_request_params)
    @other_user = User.find_by_id(@friend_request.receiver_id)

    render turbo_stream:
        turbo_stream.replace("friend_buttons",
          partial: "users/friend_buttons",
          locals: { user: @other_user, friend_request: @friend_request }
        )
  end

  def update
    @other_user = User.find_by_id(@friend_request.sender_id)
    @friend_request.update(accepted: true)

    render turbo_stream:
        turbo_stream.replace("friend_buttons",
          partial: "users/friend_buttons",
          locals: { user: @other_user, friend_request: @friend_request }
        )
  end

  def destroy
    @other_user = User.find_by_id(
      [@friend_request.sender_id, @friend_request.receiver_id]
        .select { |id| id != current_user.id }.first.to_i
    )
    @friend_request.destroy

    render turbo_stream:
        turbo_stream.replace("friend_buttons",
          partial: "users/friend_buttons",
          locals: { user: @other_user, friend_request: FriendRequest.new }
        )
  end

  private

    def set_friend_request
      @friend_request = FriendRequest.find_by_id(params[:id])
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      render_access_denied unless @user == current_user
    end

    def friend_request_params
      params.require(:friend_request).permit(:sender_id, :receiver_id)
    end
end
