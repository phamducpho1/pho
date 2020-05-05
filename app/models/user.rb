class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :suggests, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  enum admin: {normal: 0, admin: 1}
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum_length},
    format: {with: Devise::email_regexp}
  scope :sort_by_name, ->{order :name}
  scope :send_mail, ->{where(admin: Settings.admin.value)}
end
