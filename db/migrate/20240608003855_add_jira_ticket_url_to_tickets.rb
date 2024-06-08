class AddJiraTicketUrlToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :jira_ticket_url, :string
  end
end
