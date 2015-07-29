FactoryGirl.define do
  factory :user do 
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"
    password_confirmation "password"

    factory :admin_user do 
      admin true
    end
  end
end