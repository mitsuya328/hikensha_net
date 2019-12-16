class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.datetime :start_at
      t.string :email
      t.string :sex
      t.date :birth_date
      t.text :note
      t.references :experiment, null: false, foreign_key: true

      t.timestamps
    end
    add_index :subjects, [:experiment_id, :start_at]
  end
end
