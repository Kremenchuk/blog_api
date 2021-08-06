

FactoryBot.define do
  factory :article do
    title             {Faker::Lorem.words(number: rand(1..10))}
    body              {Faker::Lorem.paragraphs(number: rand(1..10))}
    category          {Faker::Book.genre}
    publication_date  {Faker::Date.between(from: 50.days.ago, to: Date.today)}
  end
end