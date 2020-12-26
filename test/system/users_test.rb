require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @login_user = FactoryBot.create(:user, email: 'login_user@example.com')
    @other_user = FactoryBot.create(:user, email: 'other_user@example.com')
    @following_user = FactoryBot.create(:user, email: 'following_user@example.com')
    @followed_user = FactoryBot.create(:user, email: 'followed_user@example.com')
  end

  test 'ユーザ一覧ページで、ページを表示したとき、ログインユーザ以外のユーザの一覧が表示されること' do
    sign_in_as(@login_user)    
    visit users_url

    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text 'other_user@example.com'
  end

  test 'ユーザ一覧ページで、特定のユーザをクリックしたとき、ユーザ詳細画面が表示されること' do
    sign_in_as(@login_user)
    visit users_url
    click_on 'other_user@example.com'

    page.assert_current_path(user_path(@other_user))
    assert_selector 'h1', text: 'ユーザ情報'
    assert_text 'other_user@example.com'
  end

  test 'ユーザ詳細ページで、フォローボタンを押したら、フォロー状態になること' do
    sign_in_as(@login_user)
    visit users_url
    click_on 'followed_user@example.com'
    click_on 'フォローする'

    assert_selector 'h1', text: 'ユーザ一覧'
    assert_text 'Following'
  end

  test 'following_userのユーザの詳細ページで、ページを表示したとき、following_userがフォローしているユーザの一覧を表示すること' do
    sign_in_as(@login_user)
    @following_user.follow(@followed_user)
    visit users_url
    click_on 'following_user@example.com'
    click_on 'フォローしているユーザの一覧'
    page.assert_current_path(following_user_path(@following_user))
    
    assert_selector 'h1', text: "ユーザ#{@following_user.id}がフォローしているユーザの一覧"
    assert_text 'followed_user@example.com'
  end
end
