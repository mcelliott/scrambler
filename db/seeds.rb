# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

['Matt', 'Giedre', 'Barb', 'Mark', 'Mike', 'Holly'].each do |flyer|
  user.flyers.create(name: flyer, hours: 50)
end

['Head Up', 'Head Down', 'Belly'].each do |category|
  user.categories.create(name: category)
end
