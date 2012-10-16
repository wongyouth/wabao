class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :num_iid
      t.string :title
      t.string :nick
      t.string :pic_url
      t.string :click_url
      t.decimal :price, precision: 10, scale: 2
      t.decimal :commission, precision: 10, scale: 2
      t.integer :volume
      t.integer :category_id

      t.timestamps
    end
  end
end
