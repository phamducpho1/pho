class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product product_id
    current_item = line_items.find_by product_id: product_id
    if current_item.blank?
      current_item = line_items.build product_id: product_id
    elsif current_item.quantity < current_item.product.quanlity
      current_item.quantity += 1
    end
    current_item
  end

  def decrease_product product_id
    current_item = line_items.find_by product_id: product_id
    current_item.quantity -= 1 if current_item.quantity > 1
    current_item
  end

  def total_price
    line_items.sum(&:total_price_product)
  end
end
