module Uploaders
  class FlyerUploader
    def initialize(params)
      @params = params
    end

    def perform
      flyers = 0
      Flyer.transaction do
        CSV.open(tempfile).each do |row|
          name = row.first
          email = row.last
          if FlyerCreator.new(name: name, email: email).perform
            flyers += 1
          else
            Rails.logger.error("failed to upload flyer: #{row}")
          end
        end
      end
      flyers
    end

    private

    def tempfile
      @tempfile ||= @params[:file].tempfile
    end
  end
end