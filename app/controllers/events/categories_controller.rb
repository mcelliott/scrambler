class Events::CategoriesController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :category

  def destroy
    participants.destroy_all
    flash[:notice] = "Category participants successfully deleted."
  end

  private

  def participants
    event.participants.where(category_id: category.id)
  end

  def category
    @category ||= Category.find params[:id]
  end

  def event
    @event ||= Event.find params[:event_id]
  end
end
