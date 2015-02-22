class VisitorsController < ApplicationController
  before_action :public_tenant_data

  def index
  end

  private

  def public_tenant_data
    if Apartment::Tenant.current == 'public'
      @tenants = {}
      Tenant.all.each do |tenant|
        country = tenant.settings(:current).country
        (@tenants[country] ||= []) << tenant
      end
      @tenants = @tenants.sort { |a, b| a.first <=> b.first }
    else

    end
  end
end
