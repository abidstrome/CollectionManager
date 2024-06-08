class TicketsController < ApplicationController
  before_action :authenticate_user!
  def new
    @ticket = Ticket.new
    @current_page = request.referer
    authorize @ticket
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
   
    
    @ticket.link = request.referer
    @ticket.collection_name = params[:ticket][:collection_name] if params[:ticket][:collection_name].present?
    authorize @ticket

    if @ticket.save
      jira_issue = create_jira_ticket(@ticket)
      if jira_issue
        @ticket.update(jira_id: jira_issue.key, status: 'Opened')
        redirect_to user_tickets_path, notice: "Ticket created successfully.Jira Ticket: #{jira_issue.key}"
      else
        @ticket.destroy
        flash[:alert] = "Failed to create Jira ticket."
        render :new
      end

    else
      render :new
    end
  end



  def index

    @tickets= current_user.tickets.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    authorize @tickets
  end

  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection_name)
  end

  def find_jira_user_by_email(email)
    begin
      response = JIRA_CLIENT.get("/rest/api/2/user/search?query=#{email}")
      users = JSON.parse(response.body)
      users.find {|user| user['emailAddress'] == email}
    rescue JIRA::HTTPError => e
      Rails.logger.error "JIRA::HTTPError while searching for user: #{e.message}"
      Rails.logger.error "Response body: #{e.response.body}"
      nil
    rescue StandardError => e
      Rails.logger.error "StandardError while searching for user: #{e.message}"
      nil
    end
  end

  def create_jira_user(email)
    begin
      user_data = {
        emailAddress: email,
        products: ['jira-software']

      }

      Rails.logger.debug "Creating Jira user with data: #{user_data.to_json}"
      response = JIRA_CLIENT.post('/rest/api/2/user', user_data.to_json, {'content_type' => 'application/json'})
      Rails.logger.debug "Jira user creation response: #{response.body}"
      JSON.parse(response.body)
    rescue JIRA::HTTPError => e
      Rails.logger.error "JIRA::HTTPError while creating user: #{e.message}"
      Rails.logger.error "Response body: #{e.response.body}"
      nil
    rescue StandardError => e
      Rails.logger.error "StandardError while creating user: #{e.message}"
      nil
    end
  end

  def create_jira_ticket(ticket)
    issue = JIRA_CLIENT.Issue.build
    jira_user = find_jira_user_by_email(current_user.email)|| create_jira_user(current_user.email)
    if jira_user.nil?
      Rails.logger.error "Failed to find or create Jira user for #{current_user.email}"
      return nil
    end
  
    begin
      fields = {
        fields: {
          project: { key: 'TEST' },
          summary: ticket.summary.to_s,
          description: "Reported by: #{current_user.email}\nLink: #{ticket.link}\nCollection: #{ticket.collection_name}",
          issuetype: { name: 'Task' },
          priority: { name: ticket.priority }, # Exclude priority to isolate issue
          reporter: { id: jira_user['accountId']}
        }
      }
      Rails.logger.debug "Creating Jira issue with fields: #{fields.inspect}"
  
      issue.save(fields)
      Rails.logger.debug "Jira Issue Created: #{issue.inspect}"
      ticket.update(jira_ticket_url: "https://tressurex.atlassian.net/browse/#{issue.key}")

      issue
    rescue JIRA::HTTPError => e
      Rails.logger.error "JIRA::HTTPError: #{e.message}"
      Rails.logger.error "Response body: #{e.response.body}"
      Rails.logger.error "Response headers: #{e.response.headers.inspect}"
      nil
    rescue StandardError => e
      Rails.logger.error "StandardError: #{e.message}"
      nil
    end
  end
  
  
end
