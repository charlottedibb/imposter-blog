FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Quote.most_interesting_man_in_the_world }
    author { Faker::Superhero.name }
  end
end
