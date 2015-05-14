$ ->
  $("input.datepicker").datepicker({ dateFormat: "dd/mm/yy", firstDay: "1", changeMonth: true, changeYear: true })

  $("select#participant_category_id").select2
    placeholder: "Select Categories"
    dropdownAutoWidth : true

  $("select#participant_flyer_id").select2
    placeholder: "Select Flyer"
    dropdownAutoWidth : true

  $(document).on "click", "#generate-teams", (e) ->
    e.preventDefault()
    $(@).attr('disabled', true)
    $('#modal').foundation('reveal', 'close');
    $('div.generating-teams').show()
    event = $(@).data('event')
    $.post("/events/#{event}/rounds")

  $(document).on "click", "#generate-mixed-teams", (e) ->
    e.preventDefault()
    $("#generate-teams").attr('disabled', true)
    $('#modal').foundation('reveal', 'close');
    $('div.generating-teams').show()
    $(@).parent().submit()

  $(document).on "change", "input.event-score", (e) ->
    ($ @).parent().submit()

  $('input[data-role=money]').autoNumeric('init');

  $(document).on 'click', '#random-participant', (e) ->
    e.preventDefault()
    participants = $("select#team_participant_participant_id").children()
    numParticipants = participants.length
    newSelected = Math.floor((Math.random() * 100) % numParticipants)
    if newSelected == 0
      newSelected = newSelected + 1

    participants.removeAttr('selected')
    $('select#team_participant_participant_id option:eq(' + newSelected + ')').attr('selected', 'selected')
    $('select#team_participant_participant_id').trigger("change")

  $(document).on 'click', '#scored-button', (e) ->
    e.preventDefault()

    input = $('#team_participant_placeholder')
    icon = input.closest('.row').find('i')
    if input.val() == '1'
      input.val(0)
      icon.removeClass('fa-exclamation-triangle');
      icon.addClass('fa-check');
      $(@).html('<i class="fa fa-check"></i> Scored')

    else
      input.val(1)
      icon.removeClass('fa-check');
      icon.addClass('fa-exclamation-triangle');
      $(@).html('<i class="fa fa-exclamation-triangle"></i> Unscored')

window.Scrambler =
  update_messages: (notice) ->
    $('#notice').html(notice).show()
    $('div#notice').delay(6000).fadeOut('slow')
