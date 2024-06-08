class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :summary
      t.string :priority
      t.string :status
      t.string :jira_id
      t.string :link
      t.string :collection_name

      t.timestamps
    end
  end
end
