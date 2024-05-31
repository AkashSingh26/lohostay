require 'faker'

50.times do
  villa = Villa.create(name: Faker::Address.unique.community)
  (Date.new(2021, 1, 1)..Date.new(2021, 12, 31)).each do |date|
    villa.calendar_entries.create(
      date: date,
      price: rand(30000..50000),
      available: [true, false].sample
    )
  end
end