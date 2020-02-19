class AddUserReferenceToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :subjects, :user, foreign_key: true
  end
end
