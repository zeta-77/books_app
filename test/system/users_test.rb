require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'userの一覧表示' do
    login_user = FactoryBot.create(:login_user)
    user = FactoryBot.create(:user)
    sign_in_as(login_user)    

    visit users_url
    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text user.email
  end

  test '特定のユーザをクリック' do
    login_user = FactoryBot.create(:login_user)
    user = FactoryBot.create(:user)
    sign_in_as(login_user)
    visit users_url
    click_on user.email

    assert_selector 'h1', text: 'ユーザ情報'
    assert_text user.email
  end

  test '特定のユーザをフォロー' do
    login_user = FactoryBot.create(:login_user)
    user = FactoryBot.create(:user)
    sign_in_as(login_user)
    visit users_url
    click_on user.email
    click_on 'フォローする'

    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text 'Following'
  end

  test '特定のユーザがフォローしているユーザの一覧' do
    login_user = FactoryBot.create(:login_user)
    following_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    sign_in_as(login_user)
    following_user.follow(followed_user)
    visit users_url
    click_on following_user.email
    click_on 'フォローしているユーザの一覧'
    
    assert_selector 'h1', text: "ユーザ#{following_user.id}がフォローしているユーザの一覧"
    assert_text followed_user.email
  end
end
