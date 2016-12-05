module ApplicationHelper
  def hidden_div_if condition, attributes = {}, &block
    if condition
      attributes['style'] = 'display:none'
    end
    content_tag 'div', attributes, &block
  end

  def number_to_currency amount
    i18n_manager = I18nManager.new
    currency_manager = CurrencyManager.new i18n_manager
    converted_amount = currency_manager.convert amount
    super converted_amount
  end
end
