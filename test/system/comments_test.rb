require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    FactoryBot.create(:ruby_book)
    FactoryBot.create(:report)
  end

  test "本へのコメント" do
    login_user = FactoryBot.create(:user)
    sign_in_as(login_user)
    visit books_url
    click_on '表示'

    assert_difference('Comment.count', 1) do
      fill_in '投稿内容', with: '素敵な本ですね。'
      click_on 'コメントする'

      assert_text '素敵な本ですね。'
      assert_text login_user.email
    end
  end

  test "本へのコメント削除" do
    sign_in_as(FactoryBot.create(:user))
    visit books_url
    click_on '表示'
    fill_in '投稿内容', with: '素敵な本ですね。'
    click_on 'コメントする'

    assert_text '素敵な本ですね。'
    assert_difference('Comment.count', -1) do
      click_on '削除'
      assert_no_text '素敵な本ですね。'
    end
  end

  test "日報へのコメント" do
    login_user = FactoryBot.create(:user)
    sign_in_as(login_user)

    visit reports_url
    click_on '詳細'
    
    assert_difference('Comment.count', 1) do
      fill_in '投稿内容', with: 'ナイスな日報ですね。'
      click_on 'コメントする'

      assert_text 'ナイスな日報ですね。'
      assert_text login_user.email
    end
  end

  test "日報へのコメント削除" do
    sign_in_as(FactoryBot.create(:user))
    visit reports_url
    click_on '詳細'
    fill_in '投稿内容', with: 'ナイスな日報ですね。'
    click_on 'コメントする'

    assert_text 'ナイスな日報ですね。'
    assert_difference('Comment.count', -1) do
      click_on '削除'
      assert_no_text 'ナイスな日報ですね。'
      assert_selector 'h1', text: 'レポート詳細'
    end
  end
end
