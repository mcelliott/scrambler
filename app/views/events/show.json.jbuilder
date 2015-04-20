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
end