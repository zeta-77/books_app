FactoryBot.define do
  factory :user, class: User do
    sequence(:email){|i| "user#{i}@example.com"}
    password {"password"}
    provider {"github"}
    sequence(:uid){|i| "uid#{i}"}
  end
end
