class I18nController < ApplicationController
  def change_locale
    redirect_to redirect_path
  end

  private
  def redirect_path
    url_for controller: params[:redirect_controller],
      action: params[:redirect_action],
      locale: params[:locale],
      only_path: true
  end
end
