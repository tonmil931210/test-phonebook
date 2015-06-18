class ApplicationController < ActionController::API
  
  after_filter :set_access_control_headers
  before_action :require_login, except: [:handle_options_request, :set_access_control_headers]

  def require_login
    if request.headers.include?('Authorization')
      @current_user = User.find_by_token(request.headers['Authorization'])
      head(401) unless @current_user 
    else
      head(401)
    end
  end

  def handle_options_request
    head(:ok) if request.request_method == "OPTIONS"
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
  
