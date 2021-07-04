class ChangePriorityColumnOnTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :priority, :integer, default: 0, null: false
  end
end
