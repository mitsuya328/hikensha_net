class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :examiner_id
      t.integer :examinee_id

      t.timestamps
    end
    add_index :relationships, :examiner_id
    add_index :relationships, [:examiner_id, :examinee_id], unique: true
  end
end
