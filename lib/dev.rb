module Dev
  class << self
    def destroy_and_recreate_metropolitan_clubs
      Club.where(type: "MetropolitantClub").destroy_all
      University.all.each do |university|
        university.create_metropolitan_clubs
      end
    end

    def update_college_images
      University.all.each do |university|
        file_path = "#{Rails.root}/public/raw-images/universities/banner/"
        image_banner = "#{file_path}#{university.slug.split('-')[0].capitalize}Header.jpg"
        image_file = "#{file_path}#{university.slug.split('-')[0].capitalize}Logo.jpg"
        begin
          university.banner.store!(File.open(image_banner)) if File.exist?(image_banner)
          university.image.store!(File.open(image_file)) if File.exist?(image_file)
          university.save!
          puts "Stored image for #{university.name}"
        rescue Exception => e
          p e
        end
        file_path = "#{Rails.root}/public/raw-images/metropolitan-clubs/banner/"
        City.all.each do |city|
          club = university.metropolitan_clubs.find_by_city_id(city.id)
          image_file = nil
          if File.exist?("#{file_path}#{city.slug}.jpeg")
            image_file = "#{file_path}#{city.slug}.jpeg"
          elsif File.exist?("#{file_path}#{city.slug}.jpg")
            image_file = "#{file_path}#{city.slug}.jpg"
          end
          next if image_file.nil?
          club.image.store!(File.open(image_file))
          club.save!
          puts "Stored image for #{university.name} Metropolitan Club at #{city.name}"
        end
      end
    end
  end
end