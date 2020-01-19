class AddAttributesToExperiments < ActiveRecord::Migration[6.0]
  def change
    change_column :experiments, :deadline, :date
    add_column :experiments, :location, :string
    add_column :experiments, :reward, :string
    add_column :experiments, :amount_of_reward, :integer
  end
end
