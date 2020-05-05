class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :line_items, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: Settings.product.price}
  validates :quanlity, presence: true, numericality: {greater_than_or_equal_to: Settings.product.quanlity}
  validates :information, presence: true, length: {maximum: Settings.product.information}
  scope :sort_by_product, ->{order "created_at DESC"}
  scope :sort_by_products, ->{order :name}
  scope :not_original, ->(id){where.not(id: id)}
  scope :find_category, ->(q){where category_id: q if q.present?}
  scope :search_by_name, ->(content){where(" name like ?", "%#{content}%") if content.present?}
  scope :search_price, ->(prices){where(price: prices) if prices.present?}
  scope :product_hot, ->{joins(:order_details)
    .where("MONTH(order_details.created_at) = ?", Date.today.month)
    .group("products.id").order("sum(order_details.quanlity) DESC")}

  def self.sum_product product
    votes = product.ratings.pluck :vote
    (votes.sum.to_f / votes.count).round Settings.round.get if product.ratings.present?
  end
end
