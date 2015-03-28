class HandicapCreator
  def perform
    TunnelHours.list.each do |th|
      Handicap.create(amount: 0.0, hours: th)
    end
  end
end
