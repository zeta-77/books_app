class CreateFollowUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_users do |t|
      t.references :following_user, foreign_key: { to_table: :users }
      t.references :followed_user, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:following_user_id, :followed_user_id], unique: true
    end
  end
end
