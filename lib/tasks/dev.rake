namespace :dev do
  desc "Development seed"
  
  task :create_users => :environment do
    10.times do |i|
      puts "Creating User#{i}"
      user = User.find_or_create_by_email!(
        first_name: "First#{i}",
        last_name: "Last#{i}",
        email: "user#{i}@cahoots.com",
        password: 'password',
        password_confirmation: 'password',
        university_id: 1+rand(3),
        graduation_year: '2005',
        major: 'Computer Science',
        location_id: 1+rand(3),
        city_id: i+1,
        state: "US"
      )
    end
  end

  task :create_metropolitan_clubs => :environment do
    Club.where(type: "MetropolitantClub").delete_all
    University.all.each do |university|
      puts "create metropolitan clubs for #{university.name}"
      City.all.each do |city|
        count = MetropolitanClub.where(university_id: university.id, city_id: city.id).size
        if count == 0
          puts "............at #{city.name}"
          club=university.metropolitan_clubs.build(city_id: city.id)
          club.name = "#{university.name} of #{city.name}"
          club.save
          puts club.errors.full_messages.join(",")
        else
          puts "++++++++#{university.name} of #{city.name} already exits"
        end
      end
    end

    file_path = "#{Rails.root}/public/raw-images/metropolitan-clubs/banner/"
    MetropolitanClub.all.each do |club|
      if club.image.blank?
        if File.exist?("#{file_path}#{club.city.slug}.jpeg")
          @image_file = "#{file_path}#{club.city.slug}.jpeg"
        elsif File.exist?("#{file_path}#{club.city.slug}.jpg")
          @image_file = "#{file_path}#{club.city.slug}.jpg"
        end
        next if @image_file.nil?
        club.image.store!(File.open(@image_file))
        if club.save
          puts "Created image for #{club.name}"
        else
          puts "Something went wrong!"
        end
      else
        puts "+++++ image already added +++++"
      end
    end

  end

  task :update_college_images => :environment do
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