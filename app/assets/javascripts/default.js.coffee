$ ->
  $("input.datepicker").datepicker({ dateFormat: "dd/mm/yy", firstDay: "1", changeMonth: true, changeYear: true })

  $("select#participant_category_id").select2
    placeholder: "Select Categories"
    dropdownAutoWidth : true

  $("select#participant_flyer_id").select2
    placeholder: "Select Flyer"
    dropdownAutoWidth : true

  $(document).on "click", "#generate-teams, #generate-mixed-teams", (e) ->
    e.preventDefault()
    $(@).attr('disabled', true)
    $('#modal').foundation('reveal', 'close');
    $('div.generating-teams').show()
    $(@).parents('form').submit()

  $(document).on "change", "input.event-score", (e) ->
    ($ @).parent().submit()

  $('div#notice').delay(2000).fadeOut('slow');

  $('input[data-role=money]').autoNumeric('init');

  $(document).on 'click', '#random-participant', (e) ->
    e.preventDefault()
    participants = $("select#team_participant_id").children()
    numParticipants = participants.length
    newSelected = Math.floor((Math.random() * 100) % numParticipants)
    if newSelected == 0
      newSelected = newSelected + 1

    participants.removeAttr('selected')
    $('select#team_participant_id option:eq(' + newSelected + ')').attr('selected', 'selected')
    $('select#team_participant_id').trigger("change")

window.Scrambler =
  update_messages: (notice) ->
    $('#notice').html(notice).show()
    $('div#notice').delay(2000).fadeOut('slow')
