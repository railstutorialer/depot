module Internationalize
  def self.included _class
    _class.class_eval do
      before_action :set_locale_from_params
    end
  end

  def set_locale_from_params
    i18n_manager = I18nManager.new
    i18n_manager.change_locale params[:locale]
  rescue I18nError => e
    flash.now[:notice] = e.message
  end
end
