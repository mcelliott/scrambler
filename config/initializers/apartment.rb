# Require whichever elevator you're using below here...
#
# require 'apartment/elevators/generic'
# require 'apartment/elevators/domain'
require 'apartment/elevators/subdomain'

#
# Apartment Configuration
#
Apartment.configure do |config|
  config.excluded_models = %w{Tenant}
  config.use_schemas = true
  config.tenant_names = lambda{ Tenant.pluck :database }
  config.persistent_schemas = ['shared_extensions', 'uuid']
end

##
# Elevator Configuration

# Rails.application.config.middleware.use 'Apartment::Elevators::Generic', lambda { |request|
#   # TODO: supply generic implementation
# }

# Rails.application.config.middleware.use 'Apartment::Elevators::Domain'

Rails.application.config.middleware.use 'Apartment::Elevators::Subdomain'
Apartment::Elevators::Subdomain.excluded_subdomains = ['www']
