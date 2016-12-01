class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    authentication_manager = AuthenticationManager.new({:session => session})
    authenticity, user_id = authentication_manager.login params[:name], params[:password]

    if authenticity
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
