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
    Dev.create_metropolitan_clubs
  end

  task :update_college_images => :environment do
    Dev.update_college_images
  end

end