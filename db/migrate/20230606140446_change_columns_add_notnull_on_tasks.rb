class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :detail, :string, null: false
  end
end
