# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_tenant(continent, country, params)
    tenant = TenantCreator.new(params).perform
    tenant.settings(:current).country = country
    tenant.settings(:current).continent = continent
    tenant.save
end

def create_tenants
  create_tenant('Australia', 'Australia', { name: 'iFly Penrith', domain: 'iflypenrith', database: 'iflypenrith' })
  create_tenant('Australia', 'Australia', { name: 'iFly Gold Coast', domain: 'iflygoldcoast', database: 'iflygoldcoast' })
  create_tenant('North America', 'U.S.A', { name: 'Eloy', domain: 'eloy', database: 'eloy' })
  create_tenant('North America', 'U.S.A', { name: 'Paraclete XP', domain: 'paracletexp', database: 'paracletexp' })
  create_tenant('Europe', 'Norway',       { name: 'Voss Vind', domain: 'vossvind', database: 'vossvind' })
  create_tenant('Europe', 'Germany',      { name: 'Bottrop', domain: 'bottrop', database: 'bottrop' })
  create_tenant('Asia', 'Singapore',      { name: 'Singapore', domain: 'singapore', database: 'singapore' })
end

if Apartment::Tenant.current == 'public'
  create_tenants
  Tenant.first.switch!
end
