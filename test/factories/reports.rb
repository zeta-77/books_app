FactoryBot.define do
  factory :report, class: Report do
    # sequence(:id){|i| i}
    title {'12月10日の日報'}
    content {'テストを実装した。'}
  end
end
