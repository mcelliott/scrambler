require 'apartment/elevators/generic'

class TenantModelElevator < Apartment::Elevators::Generic
  def self.excluded_subdomains
    @excluded_subdomains ||= []
  end

  def self.excluded_subdomains=(arg)
    @excluded_subdomains = arg
  end

  def parse_tenant_name(request)
    request_subdomain = subdomain(request.host)
    subdomain = if self.class.excluded_subdomains.include?(request_subdomain)
      nil
    else
      request_subdomain
    end

    if subdomain.present? && tenant = Tenant.find_by(domain: subdomain)
      tenant.database
    end
  end

  protected
  def subdomain(host)
    subdomains(host).first
  end

  def subdomains(host)
    return [] unless named_host?(host)

    host.split('.')[0..-(Apartment.tld_length + 2)]
  end

  def named_host?(host)
    !(host.nil? || /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.match(host))
  end
end
