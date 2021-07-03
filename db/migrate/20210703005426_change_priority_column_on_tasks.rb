class ChangePriorityColumnOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, :integer, default: 0, null: false
  end
end
