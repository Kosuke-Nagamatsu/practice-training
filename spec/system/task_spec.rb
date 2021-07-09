require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        task_list = all('#task_row td')
        expect(page).to have_content('1番目に作成したタスクのタイトル')
        expect(page).to have_content('1番目に作成したタスクのコンテント')
        expect(page).to have_content('07/10 07:15')
        expect(task_list[4]).to have_content '未着手'
      end
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, title: "task", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        fill_in 'task_title', with: 'task'
        click_button '検索する'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, title: "task", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        find("#task_status").find("option[value='未着手']").select_option
        click_button '検索する'
        task_list = all('#task_row td')
        expect(task_list[4]).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, title: "task", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        fill_in 'task_title', with: 'ta' and find("#task_status").find("option[value='未着手']").select_option
        click_button '検索する'
        task_list = all('#task_row td')
        expect(task_list[1]).to have_content 'task'
        expect(task_list[4]).to have_content '未着手'
      end
    end
  end
  describe '一覧表示機能' do
    context '優先順位でソートするというリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, title: "task", user_id: user.id)
        FactoryBot.create(:second_task, title: "task2", user_id: user.id)
        FactoryBot.create(:third_task, title: "task3", user_id: user.id)
        visit new_session_path
        fill_in 'session_email', with: 'user@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'Log in'
        visit tasks_path
        click_link '優先順位'
        task_list = all('#task_row td')
        expect(task_list[5]).to have_content '高'
      end
    end
  end
end
