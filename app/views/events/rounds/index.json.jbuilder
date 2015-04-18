json.event do

  json.category_participants @event.categories_participants do |category, participants|
    json.category_name category.name.humanize
    json.category_id category.id
    json.participants participants do |participant|
      json.name participant.flyer_name
      json.flyer_id participant.flyer_id
      json.number participant.number
    end
  end

  json.rounds @event.rounds do |round|
    json.id round.id
    json.round_number round.round_number
    json.event_id round.event_id

    json.teams round.teams do |team|
      json.id team.id
      json.name team.name
      json.category_name team.category.name.humanize

      json.team_participants team.team_participants do |team_participant|
        json.id team_participant.id
        json.name team_participant.flyer_name
        json.placeholder team_participant.placeholder
      end
    end
  end

end