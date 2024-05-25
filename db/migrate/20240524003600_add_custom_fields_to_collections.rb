class AddCustomFieldsToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :custom_bool1_state, :boolean
    add_column :collections, :custom_bool1_name, :string
    add_column :collections, :custom_bool2_state, :boolean
    add_column :collections, :custom_bool2_name, :string
    add_column :collections, :custom_bool3_state, :boolean
    add_column :collections, :custom_bool3_name, :string
    add_column :collections, :custom_date1_state, :boolean
    add_column :collections, :custom_date1_name, :string
    add_column :collections, :custom_date2_state, :boolean
    add_column :collections, :custom_date2_name, :string
    add_column :collections, :custom_date3_state, :boolean
    add_column :collections, :custom_date3_name, :string
    add_column :collections, :custom_text1_state, :boolean
    add_column :collections, :custom_text1_name, :string
    add_column :collections, :custom_text2_state, :boolean
    add_column :collections, :custom_text2_name, :string
    add_column :collections, :custom_text3_state, :boolean
    add_column :collections, :custom_text3_name, :string
  end
end
