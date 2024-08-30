class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :age, null: false
      t.string :favorite_genre, null: false
      t.string :user_name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :user_name, unique: true
  end
end
