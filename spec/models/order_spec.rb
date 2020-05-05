require "rails_helper"
RSpec.describe Order, type: :model do

  context "associations" do
    it {should belong_to :user}
    it {should have_many :order_details}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :phone}
    it {is_expected.to validate_presence_of :address}
  end
end
