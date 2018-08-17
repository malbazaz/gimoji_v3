class CreateGiftmojis < ActiveRecord::Migration[5.2]
  def change
    create_table :giftmojis do |t|
      t.string :name
      t.string :tag
      t.integer :price
      t.integer :user_id
      t.integer :occasion_id, default: 1
      t.text :message
      t.timestamps
    end
  end
end
