class ChangeStatusColumnOnTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, :integer, default: 0, null: false
  end
end
