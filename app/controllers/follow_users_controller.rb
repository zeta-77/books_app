class FollowUsersController < ApplicationController

  def create
    following = current_user.follow(followed_user(params[:followed_user_id]))
    redirect_to users_path
  end

  def destroy
    current_user.unfollow(followed_user(params[:id]))
    redirect_to users_path
  end

  private
  def followed_user(id)
    User.find(id)
  end
end  

