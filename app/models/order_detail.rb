class OrderDetail < ApplicationRecord
  belongs_to :product
  scope :find_order, ->(id){where order_id: id}
end
