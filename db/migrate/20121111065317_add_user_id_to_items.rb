class AddUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :user_id, :integer

    Item.update_all "user_id = 1"
  end
end
