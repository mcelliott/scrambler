$(function() {
  $("input.datepicker").datepicker({
    dateFormat: "dd/mm/yy",
    firstDay: "1",
    changeMonth: true,
    changeYear: true
  });
  $("select#participant_category_id").select2({
    placeholder: "Select Categories",
    dropdownAutoWidth: true
  });
  $("select#participant_flyer_id").select2({
    placeholder: "Select Flyer",
    dropdownAutoWidth: true
  });
  $(document).on("click", "#generate-teams", function(e) {
    e.preventDefault();
    $(this).attr('disabled', true);
    var event = $(this).data('event');
    Scrambler.generate_teams(event);
  });
  $(document).on("change", "input.event-score", function(e) {
    $(this).parent().submit();
  });
  $('input[data-role=money]').autoNumeric('init');
  $(document).on('click', '#random-participant', function(e) {
    var newSelected, numParticipants, participants;
    e.preventDefault();
    participants = $("select#team_participant_participant_id").children();
    numParticipants = participants.length;
    newSelected = Math.floor((Math.random() * 100) % numParticipants);
    if (newSelected === 0) {
      newSelected = newSelected + 1;
    }
    participants.removeAttr('selected');
    $('select#team_participant_participant_id option:eq(' + newSelected + ')').attr('selected', 'selected');
    $('select#team_participant_participant_id').trigger("change");
  });
  $(document).on('click', '#scored-button', function(e) {
    var icon, input;
    e.preventDefault();
    input = $('#team_participant_placeholder');
    icon = input.closest('.row').find('i');
    if (input.val() === '1') {
      input.val(0);
      icon.removeClass('fa-exclamation-triangle');
      icon.addClass('fa-check');
      $(this).html('<i class="fa fa-check"></i> Scored');
    } else {
      input.val(1);
      icon.removeClass('fa-check');
      icon.addClass('fa-exclamation-triangle');
      $(this).html('<i class="fa fa-exclamation-triangle"></i> Unscored');
    }
  });
});

window.Scrambler = {
  participantEmailSent: function() {
    $('#email-participants-button').addClass('hidden');
  },
  roundsGenerated: function() {
    $('#score-board-button').removeClass('hidden');
    $('.empty-list').addClass('hidden');
  },
  participantAdded: function() {
    $('.empty-list').addClass('hidden');
    $('#generate-teams-button').removeClass('hidden');
    $('#email-participants-button').removeClass('hidden');
  },
  participantRemoved: function(count) {
    if (count === 0) {
      $('.empty-list').removeClass('hidden');
      $('#generate-teams-button').addClass('hidden');
      $('#email-participants-button').addClass('hidden');
    }
  },
  update_messages: function(notice) {
    $('#notice').html(notice).show();
    return $('div#notice').delay(6000).fadeOut('slow');
  },
  mixedRounds: function() {
    var checkboxes = $('.mixed-rounds input:checkbox:checked');
   return checkboxes.map(function() {
      return this.name;
    }).get();
  },
  progress: function(event) {
    setInterval((function() {
      var meter = $('.meter');
      $.ajax({
        type: 'GET',
        url: event + "/rounds/status",
        dataType: 'json',
        success: function(data) {
          if (data.status === 'done') {
            meter.width('100%');
            setTimeout(location.reload(), 500);
          } else {
            meter.width(data.progress + '%');
            console.log(data.progress);
          }
          $('h5.progress-title').html('Generating Teams ' + data.progress + '%');
        },
        error: function(jqXHR, textStatus, errorThrow) {
          console.log(textStatus);
        }
      });
    }), 1000);
  },
  generate_teams: function(event) {
    $('#modal').foundation('reveal', 'close');
    $('div.progress-bar').show();

    var data = { mixed_rounds: Scrambler.mixedRounds() };
    $.ajax({
      type: 'POST',
      url: "/events/" + event + "/rounds",
      data: data,
      dataType: 'json',
      success: function(data) {
        Scrambler.progress(event);
      }
    });
  }
};
