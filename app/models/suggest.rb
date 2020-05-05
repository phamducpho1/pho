class Suggest < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  scope :order_iduser, ->{order :user_id}
end
