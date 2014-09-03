$(document).on('ready page:load', function() {

  $('.url-trigger').on('change', function() {
    console.log('triggered');
    $('.slide-down').toggleClass('slide-open');
  });

  var user_id = $('.messages').attr('data-userid');
  var challenge_id = $('.messages').attr('data-cid');

  var getMessages = function(user_id, challenge_id){
    return $.getJSON("/users/" + user_id + "/challenges/" + challenge_id + "/messages.json", function(){});
  };

  $.when(getMessages(user_id, challenge_id)).done(function(result){
    console.log(result);
    var compiledTemplate = HandlebarsTemplates['message/messages']({result: result});
    $('#msg-results').append(compiledTemplate);
  });

  function createMessage(id, c_id, data) {
    return $.ajax({
      method: 'post',
      url: "/users/" + id + "/challenges/" + c_id + "/messages",
      data: data
    });
  }

  $("#new-msg-form").on("submit", function(e){
    e.preventDefault();
    var message = {
      message: {
        text: $("#message_text").val(),
        is_private: $("#message_is_private").val(),
        is_caught: $("#message_is_caught").val(),
        is_invitation: $('#message_is_invitation').val(),
        img_url: $('#message_img_url').val(),
        challenge_id: challenge_id
      }

    };

    $.when(createMessage(user_id, challenge_id, message)).done(function(result){
      $("#message_text").val('');
      $("#message_is_private").val('');
      $("#message_is_caught").val('');
      $('#message_img_url').val('');

      console.log("returned message: ", result)

      var compiledTemplate = HandlebarsTemplates['message/messages']({result: result});
      $('#msg-results').prepend(compiledTemplate);

    })
  })

  // if is_caught is true, show confirm/deny button group
  // confirm button click
    // confirm button swap for confirmed message
    // change bg color of li
    // or deny button swap for denied message
    // update calendar?
      // if there is an is_caught message on this date, change day style
    // update caught slippin count, with date
    // update challenge balance
    // generate a caught slippin text to all participants with link to the challenge page

  // put caught slippin button on the calendar
  // show if current_user == challenge owner

});















