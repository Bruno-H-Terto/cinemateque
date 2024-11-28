class CreateMovieTheaters < ActiveRecord::Migration[8.0]
  def change
    create_table :movie_theaters do |t|
      t.string :name

      t.timestamps
    end
    add_index :movie_theaters, :name, unique: true
  end
end