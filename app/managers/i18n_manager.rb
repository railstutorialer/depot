class I18nManager
  def change_locale locale
    if locale
      if (I18n.available_locales.map &:to_s).include? locale
        I18n.locale = locale
      else
        raise (I18nError.new "#{locale} translation not available")
      end
    end
  end

  def get_locale
    I18n.locale
  end
end

class I18nError < StandardError
end
