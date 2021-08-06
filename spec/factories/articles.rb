

FactoryBot.define do
  factory :article do
    association :user
    title             {Faker::Lorem.words(rand(2..10))}
    body              {Faker::Lorem.paragraphs(rand(2..8))}
    category          {Faker::Book.genre}
    publication_date  {Faker::Date.between(from: 50.days.ago, to: Date.today)}
  end
end