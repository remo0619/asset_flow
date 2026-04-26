FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "fg834jfsf90d" }
    password_confirmation { "fg834jfsf90d" }
    authority { :user }
  end
end
