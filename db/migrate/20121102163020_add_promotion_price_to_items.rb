class AddPromotionPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :promotion_price, :decimal, precision: 10, scale: 2
  end
end
