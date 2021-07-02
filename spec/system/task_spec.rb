require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('#task_row td')
        expect(page).to have_content('2番目に作成したタスクのタイトル')
        expect(page).to have_content('2番目に作成したタスクのコンテント')
        expect(page).to have_content('2021年07月11日09時30分')
        expect(task_list[3]).to have_content '着手中'
      end
    end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title: "sample")
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'task_title', with: 'task'
        click_button '検索する'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        find("#task_status").find("option[value='未着手']").select_option
        click_button '検索する'
        task_list = all('#task_row td')
        expect(task_list[3]).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'task_title', with: 'sa' and find("#task_status").find("option[value='着手中']").select_option
        click_button '検索する'
        task_list = all('#task_row td')
        expect(task_list[0]).to have_content 'sample'
        expect(task_list[3]).to have_content '着手中'
      end
    end
  end
  # ステップ2で作成したコード
  # describe '一覧表示機能' do
  #   before do
  #     FactoryBot.create(:task)
  #     FactoryBot.create(:second_task)
  #     FactoryBot.create(:third_task)
  #     visit tasks_path
  #   end
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       expect(page).to have_content '最新のタスクのタイトル'
  #       expect(page).to have_content '最新のタスクの内容'
  #       expect(page).to have_content '2番目に作成したタスクのタイトル'
  #       expect(page).to have_content '2番目に作成したタスクのコンテント'
  #     end
  #   end
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       task_list = all('#task_row td')
  #       expect(task_list[0]).to have_content '最新のタスクのタイトル'
  #       expect(task_list[1]).to have_content '最新のタスクの内容'
  #     end
  #   end
  #   context '終了期限でソートするというリンクを押した場合' do
  #     it '終了期限の降順に並び替えられたタスク一覧が表示される' do
  #       click_link '終了期限でソートする'
  #       task_list = all('#task_row td')
  #       expect(task_list[2]).to have_content '2021年07月12日10時05分'
  #     end
  #   end
  # end
end
