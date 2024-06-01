FactoryBot.define do
    factory :villa do
        name { Faker::Address.community }
    end
end