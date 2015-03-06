class HandicapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_handicap, only: [:edit, :update]

  respond_to :html, :js

  def index
    @handicaps = Handicap.all.order(:hours)
    respond_with(@handicaps)
  end

  def edit
  end

  def update
    @handicap.update(handicap_params)
  end

  private
    def set_handicap
      @handicap = Handicap.find(params[:id])
    end

    def handicap_params
      params.require(:handicap).permit(:amount)
    end
end
