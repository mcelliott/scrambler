class EventMailer < ApplicationMailer

  def team_email(participant_id)
    load_data(participant_id)
    add_logo

    mail(
      subject: @event.title,
      to:      @flyer.email,
      from:    'notifications@skydivescrambler.com',
      date:    Time.zone.now
    )
  end

  private

  def add_logo
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/scrambler-logo.png'))
  end

  def load_data(participant_id)
    @participant = Participant.find(participant_id)
    @event = @participant.event
    @flyer = @participant.flyer
    @url = root_url
    @event_teams_url ||= team_view_url(uuid: @event.uuid)
  end
end
