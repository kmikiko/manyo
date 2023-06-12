class AddTasksIndexToNameAndStatus < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :name
    add_index :tasks, :status
  end
end
