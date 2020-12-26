require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = FactoryBot.create(:report)
    sign_in_as(FactoryBot.create(:user))
  end

  test '日報の一覧ページで、ページを表示したとき、日報の一覧ページが表示されること' do
    visit reports_url
    assert_selector 'h1', text: '日報一覧'
    assert_text '12月10日の日報'
    assert_text 'テストを実装した。'
  end

  test '日報の一覧ページで、「詳細」をクリックしたとき、対象の日報の詳細ページが表示されること' do
    visit reports_url
    click_on '詳細'
    page.assert_current_path(report_path(@report))
    assert_selector 'h1', text: 'レポート詳細'
    assert_selector 'h1', text: 'コメント'
    assert_text '12月10日の日報'
    assert_text 'テストを実装した。'
  end

  test '日報の新規登録ページで、日報を新規登録したとき、その日報が登録されること' do
    visit reports_url
    click_on '日報の新規作成'
    page.assert_current_path(new_report_path)

    assert_difference('Report.count', 1) do
      fill_in 'タイトル', with: '2021年の抱負'
      fill_in '内容', with: '肉体改造'
      click_on '登録する'
    end

    new_report = Report.last
    page.assert_current_path(report_path(new_report))

    assert_selector 'p#notice', text: '日報が登録されました。'
    assert_text '2021年の抱負'
    assert_text '肉体改造'
  end

  test '日報の編集ページで、日報の情報を編集したとき、その編集内容が反映されること' do
    visit reports_url
    click_on '編集'
    page.assert_current_path(edit_report_path(@report))

    fill_in 'タイトル', with: '12月11日の報告'
    fill_in '内容', with: 'Railsの課題終了'
    click_on '更新する'
    page.assert_current_path(report_path(@report))

    assert_selector 'p#notice', text: '日報が更新されました。'
    assert_selector 'h1', text: 'レポート詳細'
    assert_selector 'h1', text: 'コメント'
    assert_text '12月11日の報告'
    assert_text 'Railsの課題終了'   
  end

  test '日報の一覧ページで、日報を削除したとき、その日報が削除されること' do
    visit reports_url
    assert_text '12月10日の日報'
    assert_difference('Report.count', -1) do
      accept_confirm do
        click_on '削除'
      end
      page.assert_current_path(reports_path)
      assert_selector 'p#notice', text: '日報が削除されました。'
    end
    assert_no_text '12月10日の日報'
    assert_selector 'h1', text: '日報一覧'
  end
end
