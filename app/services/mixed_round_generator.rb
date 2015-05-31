class MixedRoundGenerator
  def populate_mixed_team
    combinations.each do |combination|
      unless flown_in_event?(combination) || flown_in_round?(combination)
          add_participants(combination)
      end
    end
    populate_empty_team
  end
end