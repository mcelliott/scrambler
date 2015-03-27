# Require whichever elevator you're using below here...
#
# require 'apartment/elevators/generic'
# require 'apartment/elevators/domain'
# require 'apartment/elevators/subdomain'

Apartment.configure do |config|
  config.excluded_models = %w{Tenant Page Category}
  config.use_schemas = true
  config.tenant_names = lambda{ Tenant.pluck :database }
  config.persistent_schemas = ['shared_extensions', 'uuid']
end
