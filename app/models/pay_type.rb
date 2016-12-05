class PayType < ApplicationRecord
  belongs_to :name_translation, :class_name => 'Translation'

  def name
    name_translation.current
  end
end
