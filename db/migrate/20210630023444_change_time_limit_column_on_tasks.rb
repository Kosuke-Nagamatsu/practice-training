class ChangeTimeLimitColumnOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :time_limit, :datetime, default: -> { 'now()' }, null: false
  end
end
