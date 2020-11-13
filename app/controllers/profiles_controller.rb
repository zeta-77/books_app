class ProfilesController < ApplicationController
  def show
    @following_users = current_user.followings
  end
end
