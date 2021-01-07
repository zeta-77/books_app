require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = FactoryBot.create(:ruby_book)
    sign_in_as(FactoryBot.create(:user))
  end

  test "ログイン後に、初期ページが表示されること" do
    assert_selector "h1", text: "アカウント情報"
    assert_selector "h1", text: "フォローしているユーザの一覧"
  end

  test '本の一覧ページで、ページを表示したとき、本の一覧ページが表示されること' do
    visit books_url
    assert_text 'Ruby超入門'
    assert_text 'わかりやすい'
    assert_text 'igaigaさん'
  end

  test '本の一覧ページで、「表示」をクリックしたとき、対象の本の詳細ページが表示されること' do
    visit books_url
    click_on '表示'
    page.assert_current_path(book_path(@book))
    assert_text 'Ruby超入門'
    assert_text 'わかりやすい'
    assert_text 'igaigaさん'
  end

  test '本の新規作成ページで、本を新規登録したとき、その本が登録されていること' do
    visit books_url
    click_on '新規登録'
    page.assert_current_path(new_book_path)

    assert_difference('Book.count', 1) do
      fill_in 'タイトル', with: 'ワンピース'
      fill_in 'メモ', with: 'Dの一族の物語'
      fill_in '著者', with: '尾田'
      click_on '登録する'
    end
    
    new_book = Book.last
    page.assert_current_path(book_path(new_book))

    assert_selector 'p#notice', text: '本のデータが登録されました。'
    assert_text 'ワンピース'
    assert_text 'Dの一族の物語'
    assert_text '尾田'
  end

  test '本の編集ページで、本の情報を編集したとき、その編集内容が反映されること' do
    visit books_url
    click_on '編集'
    page.assert_current_path(edit_book_path(@book))

    fill_in 'タイトル', with: 'Ruby超入門2'
    fill_in 'メモ', with: '最新版になりました。'
    fill_in '著者', with: '五十嵐さん2'
    click_on '更新する'
    page.assert_current_path(book_path(@book))

    assert_selector 'p#notice', text: '本のデータが更新されました。'
    assert_text 'Ruby超入門2'
    assert_text '最新版になりました。'
    assert_text '五十嵐さん2'   
  end

  test '本の一覧ページで、本を削除したとき、その本が削除されること' do
    visit books_url
    assert_text 'Ruby超入門'
    assert_difference('Book.count', 0) do
      accept_confirm do
        click_on '削除'
      end
    end
    page.assert_current_path(books_path)
    assert_selector 'p#notice', text: '本のデータが削除されました。'
    assert_no_text 'Ruby超入門'
  end
end
