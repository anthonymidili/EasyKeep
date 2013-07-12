# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.find_or_create_by_email(email: 'tonywinslow@yahoo.com')
if admin.encrypted_password.blank?
  admin.update_attributes(password: 'password', name: 'Anthony Midili')
end
