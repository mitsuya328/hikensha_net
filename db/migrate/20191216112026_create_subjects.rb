class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :email
      t.string :sex
      t.date :birth_date
      t.text :note

      t.timestamps
    end
  end
end
