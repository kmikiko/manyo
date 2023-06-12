class AddExpiredToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expired_at, :date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
