user = CreateAdminService.new.call
puts 'CREATED USER: ' << user.email

flyers = []
50.times do
  flyers << user.flyers.create!(name: Faker::Name.name, email: Faker::Internet.email, hours: (0..4).to_a.shuffle.first)
end

[['head_down', CategoryType::FREEFLY], ['head_up', CategoryType::FREEFLY], ['belly', CategoryType::BELLY]].each do |category|
  Category.create!(name: category[0], category_type: category[1])
end

event = Event.create!(name: 'Freefly',
                      location: 'ifly',
                      category_type: CategoryType::FREEFLY,
                      event_date: 1.month.from_now,
                      team_size: 2,
                      user: user,
                      num_rounds: 6,
                      participant_cost: 100.0)

flyers[0..25].each do |flyer|
  p = event.participants.build(user: user, flyer: flyer, category: Category.first, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end

flyers[26..49].each do |flyer|
  p = event.participants.build(user: user, flyer: flyer, category: Category.second, number: event.participants.count+1)
  p.create_payment(event: event, amount: event.participant_cost)
  p.save!
end
