class CreatePayTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :pay_types do |t|
      t.string :label
    end
  end
end
