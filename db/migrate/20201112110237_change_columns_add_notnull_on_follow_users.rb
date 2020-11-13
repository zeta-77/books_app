class ChangeColumnsAddNotnullOnFollowUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :follow_users, :following_user_id, false
    change_column_null :follow_users, :followed_user_id, false
  end
end
