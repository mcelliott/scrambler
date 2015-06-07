namespace :tunnelscrambler do
  namespace :seeds do
    desc 'Create the roles'
    task :roles => :environment do |variable|
      Tenant.all.each do |tenant|
        tenant.switch!
        puts "creating roles for #{tenant.domain}"
        [RoleType::USER, RoleType::MANAGER, RoleType::ADMIN].each do |role|
          Role.find_or_create_by({name: role})
        end
      end
    end

    desc 'Create the tenants'
    task :tenants => :environment do
      [
          { params: { name: 'iFly Penrith',       domain: 'iflypenrith',   database: 'iflypenrith', enabled: true   } },
          { params: { name: 'iFly Gold Coast',    domain: 'iflygoldcoast', database: 'iflygoldcoast', enabled: true } },
          { params: { name: 'Eloy',               domain: 'eloy',          database: 'eloy', enabled: false          } },
          { params: { name: 'Paraclete XP',       domain: 'paracletexp',   database: 'paracletexp', enabled: false   } },
          { params: { name: 'iFly Seattle',       domain: 'iflyseattle',   database: 'iflyseattle', enabled: false   } },
          { params: { name: 'iFly SFBay',         domain: 'iflysfbay',     database: 'iflysfbay', enabled: false     } },
          { params: { name: 'Montreal',           domain: 'montreal',      database: 'montreal', enabled: false      } },
          { params: { name: 'Voss Vind',          domain: 'vossvind',      database: 'vossvind', enabled: false      } },
          { params: { name: 'Bottrop',            domain: 'bottrop',       database: 'bottrop', enabled: false       } },
          { params: { name: 'Bodyflight Bedford', domain: 'bedford',       database: 'bedford', enabled: false       } },
          { params: { name: 'Windoor',            domain: 'windoor',       database: 'windor', enabled: false        } },
          { params: { name: 'Airspace',           domain: 'airspace',      database: 'airspace', enabled: false      } },
          { params: { name: 'Singapore',          domain: 'singapore',     database: 'singapore', enabled: false     } },
          { params: { name: 'iFly Dallas',        domain: 'iflydallas',    database: 'iflydallas', enabled: true     } }
      ].each do |args|
        unless Tenant.exists?(domain: args[:params][:domain])
          tenant = TenantCreator.new(args[:params]).perform
          tenant.switch!
        end
      end
    end

    desc 'Create Settings for Tenants'
    task :settings => :environment do
      args = {
          'iflypenrith'   => { continent: 'Australia',     country: 'Australia' },
          'iflygoldcoast' => { continent: 'Australia',     country: 'Australia' },
          'eloy'          => { continent: 'North America', country: 'U.S.A' },
          'paracletexp'   => { continent: 'North America', country: 'U.S.A' },
          'iflyseattle'   => { continent: 'North America', country: 'U.S.A' },
          'iflysfbay'     => { continent: 'North America', country: 'U.S.A' },
          'iflydallas'    => { continent: 'North America', country: 'U.S.A' },
          'montreal'      => { continent: 'North America', country: 'Canada' },
          'vossvind'      => { continent: 'Europe',        country: 'Norway' },
          'bottrop'       => { continent: 'Europe',        country: 'Germany' },
          'bedford'       => { continent: 'Europe',        country: 'UK' },
          'windoor'       => { continent: 'Europe',        country: 'Spain' },
          'airspace'      => { continent: 'Europe',        country: 'Belgium' },
          'singapore'     => { continent: 'Asia',          country: 'Singapore' }
      }

      Tenant.all.each do |tenant|
        puts "creating settings for #{tenant.domain}"
        tenant.settings(:current).value = args[tenant.domain]
        tenant.save
      end
    end

    desc 'Create handicaps for each tenant'
    task :handicaps => :environment do
      Tenant.all.each do |tenant|
        tenant.switch!
        puts "creating handicaps for #{tenant.domain}"
        HandicapCreator.new.perform
      end
    end

    desc 'Create Categories'
    task :categories => :environment do
      [['head_down', CategoryType::FREEFLY, true],
       ['head_up', CategoryType::FREEFLY, true],
       ['belly', CategoryType::BELLY, true],
       ['mixed', CategoryType::MIXED, false]].each do |category|
        puts "creating category #{category[0]}"
        Category.find_or_create_by(name: category[0], category_type: category[1], enabled: category[2])
      end
    end

    desc 'Create admins for tenants'
    task :admins => :environment do
      Tenant.all.each do |tenant|
        tenant.switch!
        CreateAdminService.new.call
        puts 'CREATED ADMIN USER FOR TENANT: ' << tenant.database
      end
    end

    desc 'Create flyers for first tenant'
    task :flyers => :environment do
      unless Rails.env.production?
        Tenant.first.switch!
        flyers = []
        50.times do
          flyers << Flyer.find_or_create_by(name: Faker::Name.name, email: Faker::Internet.email, hours: (0..4).to_a.shuffle.first)
        end

        event = Event.create!(name: 'Freefly',
                              category_type: CategoryType::FREEFLY,
                              event_date: 1.month.from_now,
                              team_size: 2,
                              num_rounds: 6,
                              participant_cost: 100.0)

        flyers[0..10].each do |flyer|
          p = event.participants.build(flyer: flyer, category: Category.first, number: event.participants.count+1)
          p.create_payment(event: event, amount: event.participant_cost)
          p.save!
        end

        flyers[11..21].each do |flyer|
          p = event.participants.build(flyer: flyer, category: Category.second, number: event.participants.count+1)
          p.create_payment(event: event, amount: event.participant_cost)
          p.save!
        end
      end
    end
  end # end seeds
end
