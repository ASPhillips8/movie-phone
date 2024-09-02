class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :score
      t.text :comment
      t.references :movie
      t.references :user

      t.timestamps
    end
  end
end
