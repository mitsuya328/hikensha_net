class AddExperimentReferenceToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :subjects, :experiment, foreign_key: true
  end
end
