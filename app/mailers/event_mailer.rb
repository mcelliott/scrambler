class EventMailer < ApplicationMailer
  include ApplicationHelper

  def team_email(participant_id)
    load_data(participant_id)
    add_logo

    mail(
      subject: @event.title,
      to:      @flyer.email,
      from:    'notifications@tunnelscrambler.com',
      date:    Time.zone.now
    )
  end

  private

  def add_logo
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/scrambler-logo-lrg.png'))
  end

  def load_data(participant_id)
    domain = Tenant.current_domain
    @participant = Participant.find(participant_id)
    @event = @participant.event
    @flyer = @participant.flyer
    @url = root_url(subdomain: domain)
    @event_teams_url ||= team_view_url(subdomain: domain, uuid: @event.uuid)
  end
end
