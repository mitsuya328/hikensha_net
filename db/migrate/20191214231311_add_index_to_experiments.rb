class AddIndexToExperiments < ActiveRecord::Migration[6.0]
  def change
    add_index :experiments, [:user_id, :created_at]
  end
end
