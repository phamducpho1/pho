class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :quanlity
      t.string :image
      t.string :information
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
