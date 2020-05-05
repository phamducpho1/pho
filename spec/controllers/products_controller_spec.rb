require "rails_helper"

RSpec.describe ProductController, type: :controller do
  let(:product) {FactoryGirl.create :product}
  subject {product}

  describe "GET #show" do
    before{get :show, params: {id: subject.id}}
    it "assings the requested product to product" do
      expect(assigns(:product)).to eq product
    end
    it "render new view" do
      expect(response).to render_template :show
    end
  end
end
