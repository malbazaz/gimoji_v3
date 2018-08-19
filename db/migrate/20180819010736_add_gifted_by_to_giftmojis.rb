class AddGiftedByToGiftmojis < ActiveRecord::Migration[5.2]
  def change
    add_column :giftmojis, :gifted_by, :string
  end
end
