class HandicapCreator
  def perform
    TunnelHours.list.each do |th|
      Handicap.find_or_create_by(amount: 0.0, hours: th)
    end
  end
end
