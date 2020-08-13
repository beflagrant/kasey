FactoryBot.define do
  factory :user do
    id {1}
    email { generate :email }
    password { 'password' }
  end

  factory :admin, class: User do
    id {2}
    email { generate :email }
    password { 'password' }
  end
end
