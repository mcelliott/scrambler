class FlyersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:new, :create]

  # GET /flyers
  # GET /flyers.json
  def index
    @flyers = current_user.flyers.order(name: :asc)
  end

  # GET /flyers/new
  def new
    @flyer = Flyer.new
  end

  # POST /flyers
  # POST /flyers.json
  def create
    @flyer = current_user.flyers.build(flyer_params)

    respond_to do |format|
      if @flyer.save
        format.html { redirect_to flyers_path, notice: 'Flyer was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # DELETE /flyers/1
  # DELETE /flyers/1.json
  def destroy
    @flyer.destroy
    respond_to do |format|
      format.html { redirect_to flyers_url, notice: 'Flyer was successfully destroyed.' }
    end
  end

  def update
    respond_to do |format|
      if @flyer.update(flyer_params)
        format.html { redirect_to flyers_url, notice: 'Flyer was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def flyer_params
      params.require(:flyer).permit(:name, :email, :hours)
    end
end
