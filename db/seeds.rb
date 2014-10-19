# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

['Matt', 'Giedre', 'Barb', 'Mark', 'Mike'].each do |flyer|
  Flyer.create(name: flyer, hours: 50, user: user)
end

['Head Up', 'Head Down', 'Belly'].each do |category|
  Category.create(name: category, user: user)
end
