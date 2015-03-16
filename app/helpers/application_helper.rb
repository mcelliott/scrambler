module ApplicationHelper
  def event_filters
    [{ field: :name_or_location_cont, placeholder: 'Search Name or Location', width: 'small-3' },
     { field: :event_date_eq, placeholder: 'Event Date', class: 'datepicker', width: 'small-3' }]
  end

  def flyer_filters
    [{ field: :name_or_email_cont, placeholder: 'Search Name or Email', width: 'small-3' }]
  end

  def active_controller_link(controller)
    (params[:controller] == controller) ? 'active' : ''
  end
end
