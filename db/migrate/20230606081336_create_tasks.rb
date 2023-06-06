class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :explanation
      t.date :duedate
      t.string :priority

      t.timestamps
    end
  end
end
