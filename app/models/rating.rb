class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :show_ratings, ->(id){where(product_id: id)}
  scope :order_vote, ->{order("vote DESC").group_by(&:vote)}
  scope :show_comment, ->(id){where(product_id: id)}
  scope :order_created, ->{order "created_at DESC"}

end
