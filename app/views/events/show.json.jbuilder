json.event do
  json.id @event.id

  json.links do
    json.edit edit_event_path(@event)
    json.expenses event_expenses_path(@event)
    json.add new_event_participant_path(event_id: @event.id)
    json.generate event_rounds_path(event_id: @event.id)
    json.scoreboard event_teams_path(@event)
    json.rounds event_rounds_path(@event)
    json.new new_event_round_path(@event)
  end

   json.category_participants @event.categories_participants do |category, participants|
    json.category_name category.name.humanize
    json.category_id category.id

    json.links do
      json.delete event_category_path(@event, category)
    end

    json.participants participants do |participant|
      json.id participant.id
      json.name participant.flyer_name
      json.flyer_id participant.flyer_id
      json.number participant.number

      json.links do
        json.info event_participant_path(event_id: @event.id, id: participant)
        json.delete event_participant_path(event_id: @event.id, id: participant)
      end
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

      json.links do
        json.delete event_team_path(team, event_id: round.event_id)
        json.new new_teams_participant_path(team_id: team.id, event_id: round.event.id)
      end

      json.team_participants team.team_participants do |team_participant|
        json.id team_participant.id
        json.name team_participant.flyer_name
        json.placeholder team_participant.placeholder

        json.links do
          json.info event_participant_path(event_id: @event.id, id: team_participant.participant_id)
          json.delete event_participant_path(event_id: @event.id, id: team_participant.participant_id)
        end
      end
    end
  end
end