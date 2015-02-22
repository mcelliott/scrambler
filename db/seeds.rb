# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Apartment::Tenant.current == 'public'
  tenant = TenantCreator.new(name: 'iFly Penrith', domain: 'iflypenrith', database: 'iflypenrith').perform
  tenant.settings(:current).country = 'Australia'
  tenant.save
  tenant.switch!
end


def tenants
  [
      'Australia' => {
          penrith:     { name: 'iFly Penrith', domain: 'iflypenrith', database: 'iflypenrith' },
          goldcoast:   { name: 'iFly Gold Coast', domain: 'iflygoldcoast', database: 'iflygoldcoast' }
      },
      'U.S.A' => {
          eloy:        { name: 'Eloy', domain: 'eloy', database: 'eloy' },
          paracletexp: { name: 'Paraclete XP', domain: 'paracletexp', database: 'paracletexp' },
      },
      'Norway' => {
          voss:        { name: 'Voss Vind', domain: 'vossvind', database: 'vossvind' },
      },
      'Germany' => {
          bottrop:     { name: 'Bottrop', domain: 'bottrop', database: 'bottrop' },
      }
  ]
end

