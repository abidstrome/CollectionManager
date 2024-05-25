class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :tags
      t.references :collection, null: false, foreign_key: true
      t.string :custom_string1
      t.string :custom_string2
      t.string :custom_string3
      t.integer :custom_int1
      t.integer :custom_int2
      t.integer :custom_int3
  
      t.timestamps
    end
  end
end
