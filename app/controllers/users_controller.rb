class UsersController < ApplicationController
  def edit_line
    @user = current_user
  end

  def update_line
    @user = current_user
    if @user.update(line_params)
      redirect_to users_path, notice: "LINE情報更新"
    else
      render :edit_line
    end
  end

  private

  def line_params
    params.require(:user).permit(:line_channel_id, :line_channel_secret, :line_channel_access_token)
  end
end
