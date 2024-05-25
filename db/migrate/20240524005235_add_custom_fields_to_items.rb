class AddCustomFieldsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :custom_text1, :text
    add_column :items, :custom_text2, :text
    add_column :items, :custom_text3, :text
    add_column :items, :custom_bool1, :boolean
    add_column :items, :custom_bool2, :boolean
    add_column :items, :custom_bool3, :boolean
    add_column :items, :custom_date1, :date
    add_column :items, :custom_date2, :date
    add_column :items, :custom_date3, :date
  end
end
