class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.string :body
      t.references :user

      t.timestamps
    end
    add_index :feedbacks, :user_id
  end
end
