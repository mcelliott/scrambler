class TenantCreator
  def initialize(attributes)
    @attributes = attributes
  end

  def perform
    Tenant.create!(@attributes).tap do |tenant|
      Apartment::Tenant.create(tenant.database)
      tenant.enable!
    end
  end
end
