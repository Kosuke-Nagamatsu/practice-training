require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
  end
end
