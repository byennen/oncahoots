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
        city: City.find(i+1).name,
        state: "US"
      )
    end
  end

  task :create_metropolitan_clubs => :environment do
    University.all.each do |university|
      puts "create metropolitan clubs for #{university.name}"
      City.all.each do |city|
        puts "............at #{city.name}"
        university.metropolitan_clubs.create(city_id: city.id)
      end
    end

    file_path = "#{Rails.root}/public/raw-images/metropolitan-clubs/banner/"
    MetropolitanClub.all.each do |club|
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
    end
    Club.where(type: "MetropolitantClub").delete_all
  end

end