FactoryBot.define do
  factory :device do
    device_type { "USBメモリ" }
    sequence(:serial) { |n| "SN#{n}12345" }
    status { :available }

    association :user, factory: [ :user, :admin ] # デバイス登録時に管理者ユーザーを紐付け
  end
end
