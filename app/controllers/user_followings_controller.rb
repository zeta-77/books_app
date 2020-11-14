class UserFollowingsController < ApplicationController
  def index
    @users = User.find(params[:id]).followings
  end
end
