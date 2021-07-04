require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        params_title = 'task'
        expect(Task.fuzzy_by_title(params_title)).to include(task)
        expect(Task.fuzzy_by_title(params_title)).not_to include(second_task)
        expect(Task.fuzzy_by_title(params_title).count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.full_by_status('未着手')).to include(task)
        expect(Task.full_by_status('未着手')).not_to include(second_task)
        expect(Task.full_by_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        params_title = 'task'
        expect(Task.fuzzy_by_title(params_title) & Task.full_by_status('未着手')).to include(task)
        expect(Task.fuzzy_by_title(params_title) & Task.full_by_status('未着手')).not_to include(second_task)
        expect((Task.fuzzy_by_title(params_title) & Task.full_by_status('未着手')).count).to eq 1
      end
    end
  end
  # ステップ1で作成したコード
  # describe 'バリデーションのテスト' do
  #   context 'タスクのタイトルが空の場合' do
  #     it 'バリデーションにひっかる' do
  #       task = Task.new(title: '', content: '失敗テスト')
  #       expect(task).not_to be_valid
  #     end
  #   end
  #   context 'タスクの詳細が空の場合' do
  #     it 'バリデーションにひっかかる' do
  #       task = Task.new(title: '失敗テスト', content: '')
  #       expect(task).not_to be_valid
  #     end
  #   end
  #   context 'タスクのタイトルと詳細に内容が記載されている場合' do
  #     it 'バリデーションが通る' do
  #       task = FactoryBot.build(:fourth_task, title: '成功テストのタスク名', content: '成功テストの内容')
  #       expect(task).to be_valid
  #     end
  #   end
  # end
end
