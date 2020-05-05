require "rails_helper"
RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.create :user}
  subject {user}

  context "associations" do
    it {should have_many :suggests}
    it {should have_many :orders}
    it {should have_many :ratings}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most(50)}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most(50)}
    it {is_expected.to validate_confirmation_of :password}
    it {is_expected.to validate_length_of(:password).is_at_least(6)}
  end

  context "columns" do
    it {should have_db_column(:name).of_type(:string)}
    it {should have_db_column(:email).of_type(:string)}
    it {should have_db_column(:password_digest).of_type(:string)}
    it {should have_db_column(:phone).of_type(:string)}
    it {should have_db_column(:address).of_type(:text)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when name is too long" do
    before {subject.name = Faker::Lorem.characters(55)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("is too long (maximum is 50 characters)")
    end
  end

  context "when email is not valid" do
    before {subject.email = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:email].should include("can't be blank")
    end
  end


  context "when email is too long" do
    before {subject.email = Faker::Lorem.characters(55)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:email].should include("is too long (maximum is 50 characters)")
    end
  end

  it "should have the right emails in the right order" do
   User.all.sort_by_name == (user)
  end

  it "send mail to admin" do
    User.send_mail(user.admin)
  end
end
