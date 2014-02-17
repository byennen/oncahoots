module Dev
  def self.create_metropolitan_clubs
    owner = User.find_by_email(ENV['UNIVERSITY_ADMIN_EMAIL'])
    Club.where(type: "MetropolitantClub").delete_all
    file_path = "#{Rails.root}/public/raw-images/metropolitan-clubs/banner/"
    University.all.each do |university|
      puts "create metropolitan clubs for #{university.name}"
      City.all.each do |city|
        count = MetropolitanClub.where(university_id: university.id, city_id: city.id).size
        if count == 0
          puts "............at #{city.name}"
          club=university.metropolitan_clubs.build(city_id: city.id)
          club.name = "#{university.name} of #{city.name}"
          club.user = owner
          if File.exist?("#{file_path}#{city.slug}.jpeg")
            @image_file = "#{file_path}#{city.slug}.jpeg"
          elsif File.exist?("#{file_path}#{city.slug}.jpg")
            @image_file = "#{file_path}#{city.slug}.jpg"
          end
          next if @image_file.nil?
          club.image.store!(File.open(@image_file))
          club.save
          if club.valid?
            puts "Club #{club.name} created successfully."
          else
            puts club.errors.full_messages.join(",")
          end
          # this is needed because we are embedding the ID of the model in the image path; not available till after save
          club.image.store!(File.open(@image_file))
        else
          puts "++++++++#{university.name} of #{city.name} already exits"
        end
      end
    end
  end
end