class AddTimetableIdToSubjects < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM subjects;'
    add_reference :subjects, :timetable, null: false, index: true
  end
  def down
    remove_references :subjects, :timetable, index: true
  end
end
