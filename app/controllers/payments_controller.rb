class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :edit, :update]
  authorize_resource
  respond_to :html, :js

  decorates_assigned :payment
  decorates_assigned :payments, with: PaginatedCollectionDecorator

  def index
  end

  def show
  end

  def edit
  end

  def update
    @payment.update_attributes(completed_at: update_payment_value)
  end

  def destroy
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def set_payment
    @payment = event.payments.find(params[:id])
  end

  def update_payment_value
    params[:value] == 'paid' ? Time.zone.now : nil
  end
end
