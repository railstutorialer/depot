class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def empty?
    line_items.count == 0
  end

  def total_price
    line_items.sum :total_price
  end
end
