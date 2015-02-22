module ApplicationHelper
  def event_filters
    [{ field: :name_or_location_cont, placeholder: 'Search Name or Location', width: 'small-3' },
     { field: :event_date_eq, placeholder: 'Event Date', class: 'datepicker', width: 'small-3' }]
  end

  def flyer_filters
    [{ field: :name_or_email_cont, placeholder: 'Search Name or Email', width: 'small-3' }]
  end

  def domain_url(domain)
    return "http://#{domain}.127.0.0.1.xip.io:5000" if Rails.env.development?
    "#{domain}.tunnelscrambler.herokuapp.com"
  end
end
