FactoryBot.define do
  factory :user, class: User do
    sequence(:email){|i| "user#{i}@example.com"}
    password {"password"}
    provider {"github"}
    sequence(:uid){|i| "uid#{i}"}
  end

  factory :login_user, class: User do
    email {"login_user@example.com"}
    password {"password"}
    provider {"github"}
    uid {"login_user_uid"}
  end

  factory :followed_user, class: User do
    email {"followed_user@example.com"}
    password {"password"}
    provider {"github"}
    uid {"followed_user_uid"}
  end
end
