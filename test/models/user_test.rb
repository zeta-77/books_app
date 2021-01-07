require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "followメソッドのテスト：followメソッドの実行でフォロー状態になることをDBのデータで確認" do
    following_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    following_user.follow(followed_user)
    followed_id = following_user.follow_users[0].followed_user_id
    assert followed_id == followed_user.id
  end

  test "following?メソッドのテスト：フォローしているユーザを引数で渡したときtrueになること" do
    following_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    following_user.follow(followed_user)
    assert following_user.following?(followed_user)
  end

  test "following?メソッドのテスト：フォローしていないユーザを引数で渡したときfalseになること" do
    following_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    assert_not following_user.following?(followed_user)
  end

  test "unfollowメソッドのテスト：unfollowメソッドでフォロー状態が解除されることを確認" do
    following_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    following_user.follow(followed_user)
    following_user.unfollow(followed_user)
    assert_not following_user.following?(followed_user)
  end
end
