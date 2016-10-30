class AddTotalPriceToLineItems < ActiveRecord::Migration[5.0]
  def up
    add_column :line_items, :total_price, :decimal, precision: 8, scale: 2, default: 0
    LineItem.all.each do |line_item|
      price = line_item.product.price * line_item.quantity
      line_item.total_price = price
      line_item.save!
    end
  end

  def down
    remove_column :line_items, :total_price
  end
end
