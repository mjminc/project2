$(document).on('page:load', function() {
  $('.url-trigger').on('change', function() {
    console.log('triggered');
    $('.slide-down').toggleClass('open');
  });
});