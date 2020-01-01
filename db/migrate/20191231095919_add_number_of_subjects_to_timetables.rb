class AddNumberOfSubjectsToTimetables < ActiveRecord::Migration[6.0]
  def change
    add_column :timetables, :number_of_subjects, :integer
  end
end
