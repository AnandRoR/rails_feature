class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :post_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
