module Uploaders
  class FlyerCreator
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def flyer
      hash = attributes.reject { |key, value| value.blank? }
      Flyer.create(hash)
    end
  end
end
