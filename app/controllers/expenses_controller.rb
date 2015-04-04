class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :event

  decorates_assigned :event

  def index
    @expenses_decorator = ExpensesDecorator.new(event)
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end
end
