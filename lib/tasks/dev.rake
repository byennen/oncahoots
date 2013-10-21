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

  task :create_metropolitant_clubs => :environment do
    University.all.each do |university|
      puts "create metropolitant clubs for #{university.name}"
      City.all.each do |city|
        puts "............at #{city.name}"
        university.metropolitant_clubs.create(city_id: city.id)
      end
    end
  end
end