class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :name, null: false
      t.string :gender
      t.date :dob, null: false
      t.string :profile_pic
      t.string :cover_pic
      t.string :city
      t.string :school
      t.string :workplace

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :session_token
  end
end
