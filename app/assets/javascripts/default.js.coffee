$ ->
  $("input.datepicker").datepicker({ dateFormat: "dd/mm/yy", firstDay: "1", changeMonth: true, changeYear: true })
  $("select#participant_skill_id").select2
    placeholder: "Select Skills"
    dropdownAutoWidth : true

  $("select#participant_flyer_id").select2
    placeholder: "Select Flyer"
    dropdownAutoWidth : true
