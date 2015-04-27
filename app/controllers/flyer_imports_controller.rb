require 'csv'
class FlyerImportsController < ApplicationController
  load_and_authorize_resource :user
  respond_to :html, :js

  def new
  end

  def create
    count = Uploaders::FlyerUploader.new(upload_params).perform
    flash[:notice] = "#{count} flyers uploaded."
    redirect_to flyers_path
  end

  private

  def upload_params
    params.require(:flyers_import).permit(:file)
  end
end
