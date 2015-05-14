class TeamParticipantForm < Reform::Form
  property :event_id, validates: { presence: true }
  property :participant_id, validates: { presence: true }
  property :placeholder
  property :team_id, validates: { presence: true }
end