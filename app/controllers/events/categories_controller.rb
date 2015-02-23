class Events::CategoriesController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :category

  def destroy
    participants.each.each(&:destroy)
  end

  private

  def participants
    event.participants.where(category_id: category.id)
  end

  def category
    @category ||= current_user.categories.find params[:id]
  end

  def event
    @event ||= Event.find params[:event_id]
  end
end
