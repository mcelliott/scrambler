def create_tenant(continent, country, params)
  tenant = TenantCreator.new(params).perform
  tenant.settings(:current).country = country
  tenant.settings(:current).continent = continent
  tenant.save
end

def create_tenants
  create_tenant('Australia', 'Australia', { name: 'iFly Penrith',       domain: 'iflypenrith',   database: 'iflypenrith'   })
  create_tenant('Australia', 'Australia', { name: 'iFly Gold Coast',    domain: 'iflygoldcoast', database: 'iflygoldcoast' })
  create_tenant('North America', 'U.S.A', { name: 'Eloy',               domain: 'eloy',          database: 'eloy'          })
  create_tenant('North America', 'U.S.A', { name: 'Paraclete XP',       domain: 'paracletexp',   database: 'paracletexp'   })
  create_tenant('North America', 'U.S.A', { name: 'iFly Seattle',       domain: 'iflyseattle',   database: 'iflyseattle'   })
  create_tenant('North America', 'U.S.A', { name: 'iFly SFBay',         domain: 'iflysfbay',     database: 'iflysfbay'     })
  create_tenant('North America', 'Canada',{ name: 'Montreal',           domain: 'montreal',      database: 'montreal'      })
  create_tenant('Europe', 'Norway',       { name: 'Voss Vind',          domain: 'vossvind',      database: 'vossvind'      })
  create_tenant('Europe', 'Germany',      { name: 'Bottrop',            domain: 'bottrop',       database: 'bottrop'       })
  create_tenant('Europe', 'UK',           { name: 'Bodyflight Bedford', domain: 'bedford',       database: 'bedford'       })
  create_tenant('Europe', 'Spain',        { name: 'Windoor',            domain: 'windoor',       database: 'windor'        })
  create_tenant('Europe', 'Belgium',      { name: 'Airspace',           domain: 'airspace',      database: 'airspace'      })
  create_tenant('Asia', 'Singapore',      { name: 'Singapore',          domain: 'singapore',     database: 'singapore'     })
end

def create_home_content
  content = <<END
Tunnel Scrambler is a team generator for wind tunnel <i>Scrambles</i> events.
<dl>
<dt>Flyers</dt>
<dd></dd>
<dt>Events</dt>
<dd></dd>
<dt>Teams & Rounds</dt>
<dd></dd>
<dt>Expenses</dt>
<dd></dd>
</dl>
END

  Page.create name: 'home',
              title: 'What is Tunnel Scrambler?',
              content: content
end


if Apartment::Tenant.current == 'public'
  user = CreateAdminService.new.call
  puts 'CREATED USER FOR PUBLIC TENANT: ' << user.email

  create_tenants
  Tenant.first.switch!
end

user = CreateAdminService.new.call
puts 'CREATED USER: ' << user.email

create_home_content()
HandicapCreator.new.perform

flyers = []
50.times do
  flyers << Flyer.create!(name: Faker::Name.name, email: Faker::Internet.email, hours: (0..4).to_a.shuffle.first)
end

[['head_down', CategoryType::FREEFLY, true],
 ['head_up', CategoryType::FREEFLY, true],
 ['belly', CategoryType::BELLY, true],
 ['mixed', CategoryType::MIXED, false]].each do |category|
  Category.create!(name: category[0], category_type: category[1], enabled: category[2])
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
