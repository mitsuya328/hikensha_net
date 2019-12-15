class AddDeadlineToExperiments < ActiveRecord::Migration[6.0]
  def change
    add_column :experiments, :deadline, :datetime
  end
end
