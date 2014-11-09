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
    $('div.generating-teams').show()
    $(@).parents('form').submit()
