# Build all the rounds up front
class RoundBuilder
  attr_reader :rounds, :event

  def initialize(event, mixed_rounds)
    @event = event
    @mixed_rounds = mixed_rounds
    @rounds = {}
  end

  def build
    for_each_event_round do |round_name|
      @rounds[round_name] = {}
      if mixed_round?(round_name)
        build_mixed_rounds(round_name)
      else
        build_standard_rounds(round_name)
      end
    end
  end

  private

  def mixed_round?(number)
    @mixed_rounds.include?(number)
  end

  def for_each_event_round
    event.num_rounds.times do |r|
      yield "#{r + 1}"
    end
  end

  def build_mixed_rounds(round_name)
    team_number = 1
    for_each_category_team do
      add_empty_round(round_name, team_number.to_s, CategoryType::MIXED)
      team_number += 1
    end
  end

  def build_standard_rounds(round_name)
    team_number = 1
    Category.all.each do |category|
      for_each_category_team(category) do
        add_empty_round(round_name, team_number.to_s, category.name)
        team_number += 1
      end
    end
  end

  def add_empty_round(round_name, team_name, category_name)
    @rounds[round_name][team_name] = {}
    @rounds[round_name][team_name][category_name] = []
  end

  def for_each_category_team(category = nil)
    number_of_teams(category).times do
      yield
    end
  end

  def number_of_teams(category = nil)
    return event.number_of_teams unless category
    event.number_of_teams_by_category(category.id)
  end
end
