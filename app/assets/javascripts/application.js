// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/accordion
//= require jquery-ui/datepicker
//= require jquery-ui/effect-highlight
//= require jquery-ui/tabs
//= require react
//= require react_ujs
//= require components
//= require select2
//= require foundation
//= require autonumeric
//= require_tree .

function flash_row(id) {
  setTimeout(function () {
    $(id).effect("highlight", { color: '#6C939F' }, 3000);
  }, 500);
};

$(function() {
  $(document).foundation()
  $('div#notice').delay(6000).fadeOut('slow')
});
