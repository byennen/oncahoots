namespace :dev do

  desc "Create 10 example users with emails user0@cahoots.com, user1@cahoots.com, etc... "
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

  desc 'Destroy and recreate metropolitan clubs for all universities (WARNING: THIS DELETES ALL ASSOCIATED METRO CLUB DATA LIKE RECORDS, STATUSES, TRANSACTIONS, ETC...)'
  task :destroy_and_recreate_metropolitan_clubs => :environment do
    Dev.destroy_and_recreate_metropolitan_clubs
  end

  desc 'Update college and metro club images from public/raw-images'
  task :update_college_images => :environment do
    Dev.update_college_images
  end

end