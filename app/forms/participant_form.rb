class ParticipantForm < Reform::Form
  property :category_id, validates: { presence: true }
  property :event_id, validates: { presence: true }
  property :flyer_id, validates: { presence: true, uniqueness: { scope: :event_id, message: 'already exists' } }
end