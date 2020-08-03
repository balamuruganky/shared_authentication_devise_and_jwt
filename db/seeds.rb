# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initialize default accounts:
User.create do |u|
  u.email     = 'test_admin@mydomain.com'
  u.password  = 'default'
  u.user_role = false
  u.superadmin_role = true
end

User.create do |u|
  u.email     = 'test_supervisor@mydomain.com'
  u.password  = 'default'
  u.user_role = false
  u.supervisor_role = true
end

User.create do |u|
    u.email     = 'test@mydomain.com'
    u.password  = 'default'
end
