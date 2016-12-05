class CurrencyManager
  def initialize i18n_manager
    @i18n_manager = i18n_manager
  end

  def convert amount
    locale = @i18n_manager.get_locale
    rate = CURRENCY_RATES[locale]
    amount * rate
  end
end
