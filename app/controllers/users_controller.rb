class UsersController < ApplicationController
  def show
    if current_user.id.to_s == params[:id].to_s then
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end
end
