class CreateLabellings < ActiveRecord::Migration[6.1]
  def change
    create_table :labellings do |t|
      t.references :label, foreign_key: true
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end
