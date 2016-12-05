class AddTranslationToPayTypes < ActiveRecord::Migration[5.0]
  def change
    add_reference :pay_types, :name_translation
  end
end
