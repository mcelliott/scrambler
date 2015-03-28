class ExpensesDecorator
  attr_reader :event

  delegate :num_rounds, to: :event

  def initialize(event)
    @event = event
  end

  def gross_sales
    participant_cost * number_of_participants
  end

  def net_sales
    # Net sales = Gross sales – (Customer Discounts, Returns, Allowances)
    gross_sales
  end

  def gross_profit
    # Gross profit = Net sales – Cost of goods sold
    gross_sales - cost_of_goods_sold
  end

  def gross_profit_percentage
    # Gross profit percentage = {(Net sales – Cost of goods sold)/Net sales} x 100
    ((net_sales - cost_of_goods_sold)/net_sales) * 100
  end

  def operating_profit
    # Operating Profit = Gross Profit – Total operating expenses
    gross_profit
  end

  def net_profit
    # Net profit = Operating Profit – taxes – interest
    gross_profit
  end

  def minutes_flown
    team_count * (@event.time_per_round / 60)
  end

  def rate_per_minute
    @event.rate_per_minute * 100
  end

  def participant_cost
    @event.participant_cost * 100
  end

  def number_of_participants
    @event.participants.size
  end

  def cost_of_goods_sold
    (rate_per_minute * minutes_flown)
  end

  private

  def team_count
    @event.rounds.map { |r| r.teams.count }.reduce(:+) || 0
  end
end
