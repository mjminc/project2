$(document).on('page:load', function() {

  console.log("ready event fired")
  // toggle navigation
  $('#open-nav').click(function(e) {
    e.preventDefault();
    console.log('open clicked');
    $('.main-nav').removeClass('open').addClass('open');
  });
  $('#close-nav').click(function() {
    $('.main-nav').removeClass('open');
  });

});