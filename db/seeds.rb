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
  user.flyers.create(name: flyer, hours: 50, user: user)
end

['Head Down', 'Head Up', 'Belly'].each do |category|
  user.categories.create(name: category, user: user)
end

event = Event.create(name: 'Freefly', location: 'ifly', event_date: 1.month.from_now, team_size: 2, user: user )

Flyer.all.each_with_index do |flyer, index|
  p = event.participants.build(user: user, flyer: flyer, category: Category.first, number: index+1)
  p.save!
end
