#roles
Role.create(name: 'super_admin')
Role.create(name: 'university_admin')
Role.create(name: 'member')
Role.create(name: 'club_owner')
Role.create(name: 'club_admin')
Role.create(name: 'event_admin')


#super admin user
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :first_name => 'Lance', :last_name => 'Ennen', :email => 'super_admin@cahoots-connect.com', :password => 'cahoot2013', :password_confirmation => 'cahoot2013'
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

#Locations
Location.create(name: 'Davidson, NC')
Location.create(name: 'Santa Barbara, CA')
Location.create(name: 'Sewanee, TN')
Location.create(name: 'Middlebury, VT')
Location.create(name: 'Los Angeles, CA')