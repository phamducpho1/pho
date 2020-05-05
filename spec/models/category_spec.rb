require "rails_helper"
RSpec.describe Cart, type: :model do

  context "associations" do
    it {should have_many :line_items}
  end
end
