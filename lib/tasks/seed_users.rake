require 'faker'

namespace :db do
  desc 'Also create shared_extensions Schema'
  task :user_data => :environment  do
    Tenant.first.switch!
    user = CreateAdminService.new.call
    puts 'CREATED USER: ' << user.email

    flyers = []
    50.times do
      flyers << user.flyers.create!(name: Faker::Name.name, email: Faker::Internet.email, hours: 50)
    end

    ['Head Down', 'Head Up'].each do |category|
      user.categories.create!(name: category, user: user)
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
  end
end

Rake::Task["db:seed"].enhance do
  Rake::Task["db:user_data"].invoke
end

Rake::Task["db:test:purge"].enhance do
  Rake::Task["db:user_data"].invoke
end
