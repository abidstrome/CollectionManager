JIRA_CLIENT = JIRA::Client.new(
    site: 'https://tressurex.atlassian.net',
    context_path: '',
    auth_type: :basic,
    username: ENV['JIRA_USERNAME'],
    password: ENV['JIRA_API_TOKEN']

)