class CombinationGenerator
  attr_reader :event, :combinations

  def initialize(event)
    @event = event
    @combinations = {}
  end

  def generate
    event.categories_participants.each do |category, participants|
      @combinations[category.name] = participants.
        combination(event.team_size).
          to_a.shuffle
    end
    @combinations[CategoryType::MIXED] = generate_mixed_combinations
  end

  def mixed_combinations
    @combinations[CategoryType::MIXED]
  end

  private

  def generate_mixed_combinations
    head_down = event.participants_by_category_name('head_down')
    head_up = event.participants_by_category_name('head_up')
    head_down.product(head_up)
  end
end
