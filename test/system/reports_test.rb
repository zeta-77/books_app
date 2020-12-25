require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    FactoryBot.create(:report, id: '1')
    sign_in_as(FactoryBot.create(:user))
  end

  test 'Reportの一覧表示' do
    visit reports_url
    assert_selector 'h1', text: '日報一覧'
    assert_text '12月10日の日報'
    assert_text 'テストを実装した。'
  end

  test 'Reportの詳細表示' do
    visit reports_url
    click_on '詳細'
    page.assert_current_path(report_path(1))
    assert_selector 'h1', text: 'レポート詳細'
    assert_selector 'h1', text: 'コメント'
    assert_text '12月10日の日報'
    assert_text 'テストを実装した。'
  end

  test 'Reportの新規登録' do
    visit reports_url
    click_on '日報の新規作成'
    page.assert_current_path(new_report_path)
    fill_in 'タイトル', with: '2021年の抱負'
    fill_in '内容', with: '肉体改造'
    click_on '登録する'
    page.assert_current_path(report_path(2))

    assert_selector 'p#notice', text: '日報が登録されました。'
    assert_text '2021年の抱負'
    assert_text '肉体改造'
  end

  test 'Reportの編集' do
    visit reports_url
    click_on '編集'
    page.assert_current_path(edit_report_path(1))

    fill_in 'タイトル', with: '12月11日の報告'
    fill_in '内容', with: 'Railsの課題終了'
    click_on '更新する'
    page.assert_current_path(report_path(1))

    assert_selector 'p#notice', text: '日報が更新されました。'
    assert_selector 'h1', text: 'レポート詳細'
    assert_selector 'h1', text: 'コメント'
    assert_text '12月11日の報告'
    assert_text 'Railsの課題終了'   
  end

  test 'Reportの削除' do
    visit reports_url
    accept_confirm do
      click_on '削除'
    end
    page.assert_current_path(reports_path)
    assert_selector 'p#notice', text: '日報が削除されました。'
    assert_selector 'h1', text: '日報一覧'
  end
end
