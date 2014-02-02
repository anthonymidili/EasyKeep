# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_create_by_email(email: 'gibbs183@yahoo.com')
user.update_attribute(:is_admin, true)
user.update_attribute(:is_owner, true)
if user.encrypted_password.blank?
  user.update_attributes(password: 'password', name: 'Donna Gibbs')
end

user = User.find_or_create_by_email(email: 'tonywinslow@yahoo.com')
user.update_attribute(:is_admin, true)
user.update_attribute(:is_owner, true)
if user.encrypted_password.blank?
  user.update_attributes(password: 'password', name: 'Anthony Midili')
end
