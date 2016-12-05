class Translation < ActiveRecord::Base

  has_many :translation_records

  def current
    i18n_manager = I18nManager.new
    record = translation_records.find_by :locale => i18n_manager.get_locale
    record.text
  end
end
