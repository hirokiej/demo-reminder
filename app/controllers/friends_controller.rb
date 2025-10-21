class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def show
    @friends = current_user.friends.find(params[:id])
  end

  def edit
    @friend = current_user.friends.find(params[:id])
  end

  def update
    @friend = current_user.friends.find(params[:id])
    if @friend.update(friend_params)
      redirect_to friends_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:real_name)
  end
end
