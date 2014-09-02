$(document).on('ready page:load', function() {
  $('.url-trigger').on('change', function() {
    console.log('triggered');
    $('.slide-down').toggleClass('slide-open');
  });

  //   function createMessage(id, c_id, data) {
  //     return $.ajax({
  //       method: 'post',
  //       url: "/users/" + id + "/challenges/" + c_id + "/messages",
  //       data: data
  //     });
  //   }

  //   $("#new-msg-form").on("submit", function(e){
  //   e.preventDefault();
  //   var message = {
  //     message: {
  //       text: $("#message_text").val(),
  //       is_private: $("#message_is_private").val(),
  //       is_caught: $("#message_is_caught").val(),
  //       is_invitation: $('#message_is_invitation').val(),
  //       img_url: $('#message_img_url').val()
  //     },
  //     challenge_id: $("#challenge_id").val()
  //   };
  //   var user_id = $('.message').attr('data-userid');
  //   var challenge_id = $('.message').attr('data-cid');

  //   $.when(createMessage(user_id, challenge_id, )).done(function(message){
  //     $("#message_text").val('');
  //     $("#message_is_private").val('');
  //     $("#message_is_caught").val('');
  //     $('#message_img_url').val('');

  //     console.log("returned message: ", message)

  //     // var compiledTemplate = HandlebarsTemplates['message/messages']({result: message});
  //     // $('#results').prepend(compiledTemplate);

  //   })
  // })
});