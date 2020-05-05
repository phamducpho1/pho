FactoryGirl.define do
  factory :product do
    name {Faker::Name.name}
    price 12000
    quanlity 100
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, '/app/assets/images/avatar_2x.png'))}
    information {Faker::Lorem.sentence}
    association :category, factory: :category
  end
end
