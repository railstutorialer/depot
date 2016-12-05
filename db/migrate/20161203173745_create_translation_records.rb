class CreateTranslationRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :translation_records do |t|
      t.references :translation
      t.string :locale
      t.string :text
    end

    add_index :translation_records, :locale
  end
end
