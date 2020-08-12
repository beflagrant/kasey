FactoryBot.define do
  factory :user do
    id {1}
    email { 'test-user@example.com' }
    password { 'password' }
  end

  factory :admin, class: User do
    id {2}
    email { 'test-admin@example.com' }
    password { 'password' }
  end
end
