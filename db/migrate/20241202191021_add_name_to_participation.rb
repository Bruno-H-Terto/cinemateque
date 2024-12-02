class AddNameToParticipation < ActiveRecord::Migration[8.0]
  def change
    add_column :participations, :name, :string
  end
end
