class CreateTaskEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :task_entries do |t|
      t.string :note
      t.integer :duration
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
