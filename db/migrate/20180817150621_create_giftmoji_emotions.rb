class CreateGiftmojiEmotions < ActiveRecord::Migration[5.2]
  def change
    create_table :giftmoji_emotions do |t|
      t.integer :giftmoji_id
      t.integer :emotion_id
    end
  end
end
