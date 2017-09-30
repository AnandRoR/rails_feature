class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.text :description, default: ""
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
