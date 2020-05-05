require "rails_helper"

RSpec.describe "product/show.html.erb", type: :view do
  let(:product) {FactoryGirl.create(:product)}
  subject {product}
   it "displays product details" do
    assign(:product, subject)
    assign(:related_products, [subject])
    assign(:new_products, [subject])
    assign(:recent_products, [subject])
    render
    expect(subject).to render_template("product/show")
    expect(rendered).to include(product.name)
    expect(rendered).to include(product.price.to_s)
    expect(rendered).to include(product.image.to_s)
    expect(rendered).to include(product.quanlity.to_s)
    expect(rendered).to include(product.information)
  end
end
