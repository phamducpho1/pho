require "rails_helper"
RSpec.describe LineItem, type: :model do

  context "associations" do
    it {should belong_to :product}
    it {should belong_to :cart}
  end
end
