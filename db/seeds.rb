#Roles
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

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
  first_name: ENV['SUPER_ADMIN_FIRST_NAME'].dup,
  last_name: ENV['SUPER_ADMIN_LAST_NAME'].dup,
  email: ENV['SUPER_ADMIN_EMAIL'].dup,
  password: ENV['SUPER_ADMIN_PASSWORD'].dup,
  password_confirmation: ENV['SUPER_ADMIN_PASSWORD'].dup,
  university_id: @university.id,
  graduation_year: '2005',
  major: 'Computer Science',
  location_id: @location.id
)
@super_admin.add_role :super_admin
Profile.create(user_id: @super_admin.id, skills: 'Super Admin', education: 'Super Admin', experience: 'Super Admin')

#university admin user
@university_admin = User.find_or_create_by_email(
  first_name: ENV['UNIVERSITY_ADMIN_FIRST_NAME'].dup,
  last_name: ENV['UNIVERSITY_ADMIN_LAST_NAME'].dup,
  email: ENV['UNIVERSITY_ADMIN_EMAIL'].dup,
  password: ENV['UNIVERSITY_ADMIN_PASSWORD'].dup,
  password_confirmation: ENV['UNIVERSITY_ADMIN_PASSWORD'].dup,
  university_id: @university.id,
  graduation_year: '2005',
  major: 'Computer Science',
  location_id: @location.id
)
@university_admin.add_role :university_admin
Profile.create(user_id: @university_admin.id, skills: 'University Admin', education: 'University Admin', experience: 'University Admin')