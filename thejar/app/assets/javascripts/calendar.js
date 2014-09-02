$(document).on('ready page:load', function() {
  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();

  $('#calendar').fullCalendar({});
  $('.progress-bar').click(function() {
    $('.progress-calendar').toggleClass('slideOpen');
  });

});

