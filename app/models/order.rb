class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: {not_handle: 0, handled: 1}
  validates :phone, presence: true, numericality: true
  validates :address, presence: true
  scope :sort_by_id, ->{order :id}
  scope :count_date, ->{order("DATE(created_at)").group("DATE(created_at)")}
  scope :count_month, ->{order("MONTH(created_at)").group("MONTH(created_at)")}
  scope :count_year, ->{order("YEAR(created_at)").group("YEAR(created_at)")}
  scope :find_order, ->(id){where user_id: id}
  scope :created_in_time, ->(start_time, end_time){where(created_at: start_time..end_time+1)}
end
