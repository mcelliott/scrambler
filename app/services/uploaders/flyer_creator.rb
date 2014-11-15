module Uploaders
  class FlyerCreator
    attr_reader :attributes

    def initialize(user, attributes)
      @user = user
      @attributes = attributes
    end

    def flyer
      hash = attributes.reject { |key, value| value.blank? }
      @user.flyers.create!(hash)
    end
  end
end
