$(document).ready(function() {

  // toggle navigation
  var $nav = $('.main-nav');
  $('#open-nav').click(function() {
    $('.main-nav').removeClass('open').addClass('open');
  });
  $('#close-nav').click(function() {
    $('.main-nav').removeClass('open');
  });
});