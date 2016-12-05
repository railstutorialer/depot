module Authenticate
  def self.included _class
    _class.class_eval do
      before_action :authorize
    end
  end

  def authorize
    authenticate_or_request_with_http_basic_proc = Proc.new do |proc|
      authenticate_or_request_with_http_basic &proc
    end

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
