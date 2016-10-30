class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product product
    current_item = line_items.find_by product_id: product.id
    if current_item
      current_item.quantity += 1
      current_item.total_price += product.price
    else
      current_item = line_items.build product_id: product.id, total_price: product.price
    end
    current_item
  end

  def total_price
    total = line_items.sum :total_price
    logger.debug total
    total
  end
end
