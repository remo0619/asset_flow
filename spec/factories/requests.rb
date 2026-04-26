FactoryBot.define do
  factory :request do
    start_date { Date.current }
    end_date { Date.current }
    status { :pending }

    association :user, factory: :user
    association :approver, factory: [ :user, :admin ]
    association :device, factory: :device
  end
end
