json.array!(@teams) do |team|
  json.extract! team, :id, :participant_id, :event_id, :team_name
  json.url team_url(team, format: :json)
end
