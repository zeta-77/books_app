require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'ユーザ一覧ページで、ページを表示したとき、ログインユーザ以外のユーザの一覧が表示されること' do
    login_user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    sign_in_as(login_user)    

    visit users_url
    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text other_user.email
  end

  test 'ユーザ一覧ページで、特定のユーザをクリックしたとき、ユーザ詳細画面が表示されること' do
    login_user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    sign_in_as(login_user)
    visit users_url
    click_on other_user.email

    assert_selector 'h1', text: 'ユーザ情報'
    assert_text other_user.email
  end

  test 'ユーザ詳細ページで、フォローボタンを押したら、フォロー状態になること' do
    login_user = FactoryBot.create(:user)
    followed_user = FactoryBot.create(:user)
    sign_in_as(login_user)
    visit users_url
    click_on followed_user.email
    click_on 'フォローする'

    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text 'Following'
  end

  test 'following_userのユーザの詳細ページで、ページを表示したとき、following_userがフォローしているユーザの一覧を表示すること' do
    login_user = FactoryBot.create(:user)
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
