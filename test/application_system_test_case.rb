require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def sign_in_as(user)
    visit root_url
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログイン'    
  end
end
