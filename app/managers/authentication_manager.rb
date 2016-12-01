class AuthenticationManager
  def initialize params
    @session = params[:session]
    @request = params[:request]
    @authenticate_or_request_with_http_basic = params[:authenticate_or_request_with_http_basic]
  end

  def authenticate
    if @request.format != Mime[:html]
      @authenticate_or_request_with_http_basic.call (method :login).to_proc
    else
      return @session[:user_id]
    end
  end

  def login username, password
    authenticity, user_id = get_user_and_authenticity username, password

    @session[:user_id] = user_id

    authenticity
  end

  def get_user_and_authenticity username, password
    user = User.find_by :name => username
    if not user.nil?
      authenticity = user.authenticate password
      user_id = user.id
      return authenticity, user_id
    else
      authenticity = User.count == 0
      user_id = -1
      return authenticity, user_id
    end
  end
end
