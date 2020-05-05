require "rails_helper"
RSpec.describe Product, type: :model do
  let(:product) {FactoryGirl.create :product}
  subject {product}
  let(:category1) {FactoryGirl.create :category}
  let(:category2) {FactoryGirl.create :category}
  let(:product1) {FactoryGirl.create :product, name: Faker::Name.name, price: 10000,
      quanlity: 1, information: "abcxyz123", category: category1}
  let(:product2) {FactoryGirl.create :product, name: Faker::Name.name, price: 10000,
      quanlity: 1, information: "abcxyz", category: category2}
  context "associations" do
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many :ratings}
    it {is_expected.to have_many :order_details}
    it {is_expected.to have_many :line_items}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_uniqueness_of :name}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1.0)}
    it {is_expected.to validate_presence_of :quanlity}
    it {is_expected.to validate_numericality_of(:quanlity).is_greater_than_or_equal_to(1)}
    it {is_expected.to validate_presence_of :information}
    it {is_expected.to validate_length_of(:information).is_at_most(255)}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:image).of_type(:string)}
    it {is_expected.to have_db_column(:quanlity).of_type(:integer)}
    it {is_expected.to have_db_column(:information).of_type(:string)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when price is not valid" do
    before {subject.price = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:price].should include("can't be blank")
    end
  end

  context "When price is not number" do
    before {subject.price = "minh"}
    it "matches the error message" do
      subject.valid?
      subject.errors[:price].should include("is not a number")
    end
  end

  context "When price is less than 1.0" do
    before {subject.price = 0}
    it "matches the error message" do
      subject.valid?
      subject.errors[:price].should include("must be greater than or equal to 1.0")
    end
  end

  context "when quanlity is not valid" do
    before {subject.quanlity = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:quanlity].should include("can't be blank")
    end
  end

  context "When quanlity is not number" do
    before {subject.quanlity = "minh"}
    it "matches the error message" do
      subject.valid?
      subject.errors[:quanlity].should include("is not a number")
    end
  end

  context "When quanlity is less than 1.0" do
    before {subject.quanlity = 0}
    it "matches the error message" do
      subject.valid?
      subject.errors[:quanlity].should include("must be greater than or equal to 1")
    end
  end

  context "when information is not valid" do
    before {subject.information = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:information].should include("can't be blank")
    end
  end

  context "when information is too long" do
    before {subject.information = Faker::Lorem.characters(260)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:information].should include("is too long (maximum is 255 characters)")
    end
  end

  context "#sort_by_product" do
    it "return list product if has category" do
      Product.all.sort_by_product == (product)
    end
  end

  context "#sort_by_products" do
    it "return list product if has category" do
      Product.all.sort_by_products == (product)
    end
  end

  context "not_original" do
    it "should find product with diffirent id" do
      Product.not_original(product.id) == (product)
    end
  end

  describe "#find_category" do
    it "return list product of category if has category" do
      expect(Product.find_category(category1.id)).to eq [product1]
    end
  end

 describe "#search_price" do
    it "return list product of category if has price" do
      expect(Product.search_price(product1.price)) == (product)
    end
  end

  describe "#search_by_name" do
    it "return list product of category if has name" do
      expect(Product.search_by_name(product1.name)) == (product)
    end
  end
end
