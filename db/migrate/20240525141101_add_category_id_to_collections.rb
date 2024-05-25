class AddCategoryIdToCollections < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:collections, :category_id)
      add_reference :collections, :category, null: false, foreign_key: true
    end
  end
end
