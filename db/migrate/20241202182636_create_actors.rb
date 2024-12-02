class CreateActors < ActiveRecord::Migration[8.0]
  def change
    create_table :actors do |t|
      t.string :name
      t.date :birth_date
      t.string :nationality

      t.timestamps
    end
  end
end
