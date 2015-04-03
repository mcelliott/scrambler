class Events::EmailsController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :event

  def new
    email_service = EmailService.new(params)
    @email_service_decorator = EmailServiceDecorator.new(email_service)
  end

  def create
    EmailService.new(params).send
    flash[:notice] = 'Participants have been emailed.'
  end

  private

  def event
    @event ||= Event.find params[:event_id]
  end
end
