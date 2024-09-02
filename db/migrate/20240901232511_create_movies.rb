class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :run_time
      t.string :rating
      t.date :release_date

      t.timestamps
    end
  end
end
