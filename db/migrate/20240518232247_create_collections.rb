class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :image_url
      t.boolean :custom_string1_state
      t.string :custom_string1_name
      t.boolean :custom_string2_state
      t.string :custom_string2_name
      t.boolean :custom_string3_state
      t.string :custom_string3_name
      t.boolean :custom_int1_state
      t.string :custom_int1_name
      t.boolean :custom_int2_state
      t.string :custom_int2_name
      t.boolean :custom_int3_state
      t.string :custom_int3_name

      t.timestamps
    end
  end
end
