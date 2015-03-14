user = CreateAdminService.new.call
puts 'CREATED USER: ' << user.email

flyers = []
50.times do
  flyers << user.flyers.create!(name: Faker::Name.name, email: Faker::Internet.email, hours: (0..4).to_a.shuffle.first)
end

['Head Down', 'Head Up', 'Belly'].each do |category|
  Category.create!(name: category)
end

event = Event.create!(name: 'Freefly', location: 'ifly', event_date: 1.month.from_now, team_size: 2, user: user, num_rounds: 3, participant_cost: 100.0 )

flyers[0..25].each do |flyer|
  p = event.participants.build(user: user, flyer: flyer, category: Category.first, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end

flyers[26..49].each do |flyer|
  p = event.participants.build(user: user, flyer: flyer, category: Category.last, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end
