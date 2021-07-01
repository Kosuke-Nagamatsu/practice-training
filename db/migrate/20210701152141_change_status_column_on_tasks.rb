class ChangeStatusColumnOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :string, default: '未着手', null: false
  end
end
