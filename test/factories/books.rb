FactoryBot.define do
  factory :ruby_book, class: Book do
    # sequence(:id){|i| i}
    title {"Ruby超入門"}
    memo {"わかりやすい"}
    author {"igaigaさん"}
  end
end
