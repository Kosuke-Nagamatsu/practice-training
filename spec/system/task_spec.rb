require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:task, time_limit: '2021-07-07 07:07:00')
        visit tasks_path
        expect(page).to have_content('1番目に作成したタスクのタイトル').and have_content('1番目に作成したタスクのコンテント').and have_content('2021年07月07日07時07分')
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content '最新のタスクのタイトル'
        expect(page).to have_content '最新のタスクの内容'
        expect(page).to have_content '2番目に作成したタスクのタイトル'
        expect(page).to have_content '2番目に作成したタスクのコンテント'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('#task_row td')
        expect(task_list[0]).to have_content '最新のタスクのタイトル'
        expect(task_list[1]).to have_content '最新のタスクの内容'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_link '終了期限でソートする'
        task_list = all('#task_row td')
        expect(task_list[2]).to have_content '2021年07月06日10時05分'
      end
    end
  end
end
