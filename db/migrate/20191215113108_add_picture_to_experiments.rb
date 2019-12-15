class AddPictureToExperiments < ActiveRecord::Migration[6.0]
  def change
    add_column :experiments, :picture, :string
  end
end
