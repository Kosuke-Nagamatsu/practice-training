class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :time_limit
      t.string :status
      t.timestamps
    end
  end
end
