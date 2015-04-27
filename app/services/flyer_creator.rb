class FlyerCreator
  def initialize(params)
    @params = params
  end

  def perform
    Flyer.new(@params).save
  end
end
