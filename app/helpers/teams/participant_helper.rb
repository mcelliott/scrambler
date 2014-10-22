module Teams::ParticipantHelper
  def participant_form_label(p)
    "#{p.flyer.name} - #{p.category.name}"
  end
end
