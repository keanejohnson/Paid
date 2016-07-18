FactoryGirl.define do
  factory :user do
    first_name "George"
    last_name "Washington"
    email "crossthedelaware@gmail.com"
    password "independence"
    password_confirmation "independence"
  end
end
