#roles
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

#super admin user
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :first_name => ENV['ADMIN_FIRST_NAME'].dup, :last_name => ENV['ADMIN_LAST_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.first_name
user.add_role :super_admin
Profile.create(user_id: user.id, skills: 'Super Admin', education: 'Super Admin', experience: 'Super Admin')

#university admin user
user2 = User.find_or_create_by_email first_name: "Carol", last_name: "Quillen", email: 'university_admin@cahoots-connect.com', password: 'cahoot2013', password_confirmation: 'cahoot2013'
puts 'user: ' << user2.first_name
user.add_role :university_admin
Profile.create(user_id: user2.id, skills: 'University Admin', education: 'University Admin', experience: 'University Admin')

#Universities
University.create(name: 'Davidson College')
University.create(name: 'Westmont College')
University.create(name: 'Sewanee University')
University.create(name: 'Middlebury College')
University.create(name: 'Occidental College')