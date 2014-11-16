require 'csv'
class FlyerImportsController < ApplicationController
  load_and_authorize_resource :user
  respond_to :html, :js

  def new
  end

  def create
    @flyers = []
    Flyer.transaction do
      CSV.open(params[:flyers_import][:file].tempfile, headers: true).each do |row|
        hash = row.to_hash
        hash.each_pair { |name, value| hash[name] = value.strip if value }
        @flyers << Uploaders::FlyerCreator.new(current_user, hash).flyer
      end
    end
    flash[:notice] = "#{@flyers.length} flyers uploaded successfully."
    redirect_to flyers_path
  end
end
