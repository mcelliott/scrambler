class MixedRoundCreator
  attr_reader :event
  def initialize(event, params, team_list)
    @event = event
    @params = params
    @team_list = team_list
    @combinations = {}
  end

  def perform
    return unless @params[:mixed_rounds]
    # create teams that are mixed head up / head down
    # can't have a team where head up flyers count is greater than (team_size / 2)
    ## sit cannot do head down moves
  end

  private

  def round_numbers
    @params[:mixed_rounds]
  end
end
