class AddAttributeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sex, :string
    add_column :users, :birth_date, :date
  end
end
