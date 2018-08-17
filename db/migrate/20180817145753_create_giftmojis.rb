class CreateGiftmojis < ActiveRecord::Migration[5.2]
  def change
    create_table :giftmojis do |t|
      t.string :name
      t.string :tag
      t.integer :price
      t.integer :user_id
      t.text :message
      t.integer :occasion_id

      t.timestamps
    end
  end
end
