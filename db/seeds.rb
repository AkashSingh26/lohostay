require 'faker'

50.times do
  villa = Villa.create(name: Faker::Address.unique.community)
  (Date.new(2024, 1, 1)..Date.new(2024, 12, 31)).each do |date|
    villa.calendar_entries.create(
      date: date,
      price: rand(30000..50000),
      available: [true, false].sample
    )
  end
end

# To Add  Image placeholder
# Villa.all.each do |villa|
#     image_url = Faker::LoremPixel.image(size: "640x480", grayscale: false)  # Customize image size and grayscale preference as needed
#   unless villa.images.attached?
#     villa.images.attach(io: URI.open(image_url), filename: "villa_#{villa.id}.jpg")
#     villa.save!
#   end
# end
