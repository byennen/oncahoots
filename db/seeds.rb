#roles
puts 'Adding Roles'
Role.create(name: 'super_admin')
Role.create(name: 'university_admin')
Role.create(name: 'member')
Role.create(name: 'club_owner')
Role.create(name: 'club_admin')
Role.create(name: 'event_admin')

#Universities
puts 'Adding Universities'
@university = University.create(name: 'Davidson College')
University.create(name: 'Westmont College')
University.create(name: 'Sewanee University')
University.create(name: 'Middlebury College')
University.create(name: 'Occidental College')

#Locations
puts 'Adding Locations'
@location = Location.create(name: 'Davidson, NC')
Location.create(name: 'Santa Barbara, CA')
Location.create(name: 'Sewanee, TN')
Location.create(name: 'Middlebury, VT')
Location.create(name: 'Los Angeles, CA')

#super admin user
puts 'DEFAULT USERS'
puts 'Add Super Admin'
@super_admin = User.find_or_create_by_email(
  first_name: 'Lance',
  last_name: 'Ennen',
  email: 'super_admin@cahoots-connect.com',
  password: 'cahoot2013',
  password_confirmation: 'cahoot2013',
  university_id: @university.id,
  graduation_year: 2005,
  major: 'Computer Science',
  location_id: @location.id
)
@super_admin.add_role :super_admin
Profile.create(user_id: @super_admin.id, skills: 'Super Admin', education: 'Super Admin', experience: 'Super Admin')
puts @super_admin.inspect

#university admin user
@university_admin = User.find_or_create_by_email(
  first_name: "Carol",
  last_name: "Quillen",
  email: 'university_admin@cahoots-connect.com',
  password: 'cahoot2013',
  password_confirmation: 'cahoot2013',
  university_id: @university.id,
  graduation_year: 2005,
  major: 'Computer Science',
  location_id: @location.id
)
@university_admin.add_role :university_admin
Profile.create(user_id: @university_admin.id, skills: 'University Admin', education: 'University Admin', experience: 'University Admin')
puts @university_admin.inspect
