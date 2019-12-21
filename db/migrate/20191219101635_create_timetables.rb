class CreateTimetables < ActiveRecord::Migration[6.0]
  def change
    create_table :timetables do |t|
      t.datetime :start_at
      t.references :experiment, null: false, foreign_key: true

      t.timestamps
    end
    add_index :timetables, [:experiment_id, :start_at]
  end
end
