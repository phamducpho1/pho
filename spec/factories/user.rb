FactoryGirl.define do
  factory :user do
    name "phopham"
    password "123123123"
    password_confirmation "123123123"
    admin 1
    phone "0965600364"
    email "pha@gmail.com"
    address "cc"
  end
end
