class AddClickCounterToItems < ActiveRecord::Migration
  def change
    add_column :items, :click_counter, :integer, default: 0
  end
end
