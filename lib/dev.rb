module Dev
  class << self
    def create_metropolitan_clubs
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
            club.memberships.create!(admin: true, title: 'Founder', user_id: club.user.id)
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

    def update_college_images
      file_path = "#{Rails.root}/public/raw-images/universities/banner/"
      University.all.each do |university|
        image_banner = "#{file_path}#{university.slug.split('-')[0].capitalize}Header.jpg"
        image_file = "#{file_path}#{university.slug.split('-')[0].capitalize}Logo.jpg"
        begin
          university.banner.store!(File.open(image_banner)) if File.exist?(image_banner)
          university.image.store!(File.open(image_file)) if File.exist?(image_file)
          university.save!
          puts "Created image for #{university.name}"
        rescue Exception => e
          p e
        end
      end
    end
  end
end