class FlyersController < ApplicationController
  include UndoDelete
  before_action :authenticate_user!
  load_and_authorize_resource
  respond_to :html, :js

  decorates_assigned :flyer
  decorates_assigned :flyers, with: PaginatedCollectionDecorator

  def index
    @q = Flyer.order(name: :asc).search(params[:q])
    @flyers = @q.result.page(params[:page])
  end

  def new
    @flyer = Flyer.new
  end

  def create
    @flyer = Flyer.new(flyer_params)
    flash[:notice] = 'Flyer was successfully created.' if @flyer.save
  end

  def destroy
    if @flyer.destroy
      flash[:notice] = "Flyer was successfully deleted. #{undo_link(@flyer)}"
    else
      flash[:alert] = 'Failed to delete flyer.'
    end
  end

  def update
    flash[:notice] = 'Flyer was successfully updated.' if @flyer.update(flyer_params)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def flyer_params
    params.require(:flyer).permit(:name, :email, :hours)
  end
end
