class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  include HandleGlobalError

  protected
  def authorize
    authenticate_or_request_with_http_basic_proc = Proc.new do |proc|
      authenticate_or_request_with_http_basic &proc
    end
    
    logger.debug "PROC"
    logger.debug authenticate_or_request_with_http_basic_proc
    authentication_manager = AuthenticationManager.new({
      :session => session,
      :request => request,
      :authenticate_or_request_with_http_basic => authenticate_or_request_with_http_basic_proc
    })
    unless authentication_manager.authenticate
      redirect_to login_url, notice: "Please log in"
    end
  end
end
