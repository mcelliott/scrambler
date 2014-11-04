class FlyersController < ApplicationController
  load_and_authorize_resource except: [:new]

  # GET /flyers
  # GET /flyers.json
  def index
    @flyers = current_user.flyers
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
        format.json { render :show, status: :created, location: @flyer }
      else
        format.html { render :new }
        format.json { render json: @flyer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flyers/1
  # DELETE /flyers/1.json
  def destroy
    @flyer.destroy
    respond_to do |format|
      format.html { redirect_to flyers_url, notice: 'Flyer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def flyer_params
      params.require(:flyer).permit(:name, :hours)
    end
end
