# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

flyers = ['Matt', 'Giedre', 'Barb', 'Mark', 'Mike', 'Holly']
flyers.each do |flyer|
  user.flyers.create!(name: flyer, hours: 0, user: user, email: "#{flyer.downcase}@example.com")
end

['Head Down', 'Head Up'].each do |category|
  user.categories.create!(name: category, user: user)
end

event = Event.create!(name: 'Freefly', location: 'ifly', event_date: 1.month.from_now, team_size: 2, user: user, num_rounds: 3, participant_cost: 100.0 )

Flyer.all.each_with_index do |flyer, index|
  p = event.participants.build(user: user, flyer: flyer, category: Category.first, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end

flyers = ['Tim', 'Yana', 'Rampage', 'Tali', 'Sally', 'Millie', 'Amber']
flyers.each do |flyer|
  user.flyers.create!(name: flyer, hours: 0, user: user, email: "#{flyer.downcase}@example.com")
end

flyers.each_with_index do |flyer, index|
  f = Flyer.find_by name: flyer
  p = event.participants.build(user: user, flyer: f, category: Category.last, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end
