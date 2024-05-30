class UpdateCategoriesAddUniqueIndexToName < ActiveRecord::Migration[7.1]
  def up
    # Remove the unique constraint from the name column
    change_column :categories, :name, :string, null: false

    # Add a unique index to the name column
    add_index :categories, :name, unique: true
  end

  def down
    # Remove the unique index from the name column
    remove_index :categories, :name

    # Re-add the unique constraint to the name column
    change_column :categories, :name, :string, null: false, unique: true
  end
end
