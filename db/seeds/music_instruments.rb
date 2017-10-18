class SeedInstruments

  def self.seed
    category = Category.create(name: "Musical Instruments")
    suckr = ImageSuckr::GoogleSuckr.new
    category.items = 60.times do
      title = Faker::Music.instrument
      Item.create(title: title,
                  description: BetterLorem.w,
                  price: rand(0.10..140.00),
                  image: suckr.get_image_url({"q" => title}))
      puts "musical instrument seeded"
    end; return nil
   end

end
