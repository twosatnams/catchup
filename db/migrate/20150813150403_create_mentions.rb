class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :post_id, null: false
      t.integer :mentioned_user_id, null: false

      t.timestamps null: false
    end

    add_index :mentions, :post_id
    add_index :mentions, :mentioned_user_id
  end
end
