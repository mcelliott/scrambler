module EventsHelper

  ###### LINKS

  def new_participant_link(event)
    link_to fa_icon('plus', text: 'New Participant'), new_event_participant_path(event_id: event.id), remote_button_class('new-participant-button')
  end

  def show_teams_link(event)
    link_to fa_icon('table', text: 'Show Teams'), event_teams_path(event_id: event.id), button_class
  end

  def edit_event_link(event)
    link_to fa_icon('pencil', text: 'Edit Event'), edit_event_path(event), remote_button_class
  end

  def expenses_link(event)
    link_to fa_icon('money', text: 'Expenses'), event_expenses_path(event_id: event.id), button_class
  end

  def generate_teams_link(event)
    button_to 'Generate Teams', { action: 'generate', event_id: event.id }, { class: 'button-xs radius', id: 'generate-teams', remote: true }
  end

  def send_link(event)
    link_to fa_icon('send', text: 'Send'), event_email_path(event_id: event), remote_button_class.merge(method: :put)
  end

  def go_to_event_link(event)
    link_to "Go to Event", event, class: 'button-xs'
  end

  def button_class
    { class: 'button-xs' }
  end

  def remote_button_class(c = '')
    { class: "button-xs #{c}", remote: true }
  end

  ###### TABS

  def active_tab(index)
    active =  index == 0 ? 'active tab-title' : 'tab-title'
    content_tag :li, class: active, role: 'presentational' do
      yield
    end
  end

  def active_content(index, id)
    active = index == 0 ? ' active' : ''
    content_tag :section, role: 'tabpanel', class: "content#{active}", id: id, aria: { hidden: true } do
      yield
    end
  end

  def team_category(index)
    tc = index > 0 ? ' team-category' : ''
    content_tag(:div, class: "large-12 columns#{tc}") do
      yield
    end
  end

  def money(amount)
    humanized_money_with_symbol Money.new(amount)
  end
end
