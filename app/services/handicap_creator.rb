class HandicapCreator
  def initialize(user)
    @user = user
  end

  def perform
    TunnelHours.list.each do |th|
      Handicap.create(user: @user, amount: 0.0, hours: th)
    end
  end
end
