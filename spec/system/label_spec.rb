require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      FactoryBot.create(:label)
    end
    context 'タスクを新規作成する場合' do
      it 'ラベルも一緒に登録できる' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit new_task_path
        fill_in 'task_title', with: 'テスト'
        fill_in 'task_content', with: 'テスト'
        find("#task_time_limit_1i").find("option[value='2021']").select_option
        find("#task_time_limit_2i").find("option[value='8']").select_option
        find("#task_time_limit_3i").find("option[value='1']").select_option
        find("#task_time_limit_4i").find("option[value='10']").select_option
        find("#task_time_limit_5i").find("option[value='00']").select_option
        find("option[value='未着手']").select_option
        find("option[value='高']").select_option
        check "チーム"
        click_button '登録する'
        click_button '登録する'
        expect(page).to have_content('新規作成しました！')
      end
    end
    context 'タスクとラベルを一緒に登録した場合' do
      it 'タスクの詳細画面でラベル一覧を出力できる' do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, time_limit: "2021-09-14 10:00:00", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit task_path(task.id)
        expect(page).to have_content('チーム')
      end
    end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:label)
    end
    context 'ラベル検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, time_limit: "2021-09-14 10:00:00", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        click_button '検索する'
        click_link '詳細'
        expect(page).to have_content 'チーム'
      end
    end
  end
end
