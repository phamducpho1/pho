class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
