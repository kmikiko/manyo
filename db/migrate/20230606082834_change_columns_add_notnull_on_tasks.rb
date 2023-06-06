class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :explanation, :string, null: false
    change_column :tasks, :duedate, :date, null: false
    change_column :tasks, :priority, :string, null: false
  end
end
