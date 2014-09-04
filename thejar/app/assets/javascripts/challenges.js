$(document).on('ready page:load', function() {

  if ($('body').hasClass('challenges')) {


  // open file upload field in new message form
  $('.url-trigger').on('change', function() {
    console.log('triggered');
    $('.slide-down').toggleClass('slide-open');
  });

  var user_id = $('.messages').attr('data-userid');
  var challenge_id = $('.messages').attr('data-cid');
  var isOwner = $('.messages').attr('data-isOwner');

  // post user challenge message update
  var setConfirmed = function(id, c_id, msgId) {
    return $.ajax({
      url: "/users/" + id + "/challenges/" + c_id + "/messages/" + msgId,
      method: 'put',
      data: {
        message: {
          is_confirmed: true
        }
      }
    });
  };

  var getChallenge = function(user_id, challenge_id) {
    return $.getJSON("/users/" + user_id + "/challenges/" + challenge_id, function() {});
  };

  // get all messages related to this challenge
  var getMessages = function(user_id, challenge_id){
    return $.getJSON("/users/" + user_id + "/challenges/" + challenge_id + "/messages.json", function(){});
  };

  $.when(getChallenge(user_id, challenge_id)).done(function(result) {
    console.log("challenge result: ", result)
    var compiledTemplate = HandlebarsTemplates['challenge/balance']({result: result});
    $('#balance').html(compiledTemplate);
  });

  // get messages on initial page load
  $.when(getMessages(user_id, challenge_id)).done(function(result){
    console.log(result);
    var compiledTemplate = HandlebarsTemplates['message/messages']({result: result});
    $('#msg-results').append(compiledTemplate);

    // caught button click handler
    $('.caught').click(function() {
      var $self = $(this)
      console.log('caught clicked')
      var msgId = $(this).attr('data-msgid');
      var userId = $(this).attr('data-userid')
      $.when(setConfirmed(userId, challenge_id, msgId)).done(function(result) {
        console.log(result);
        $self.css('opacity', '0');

        $.when(getChallenge(user_id, challenge_id)).done(function(result) {
            console.log("challenge result: ", result)
            var compiledTemplate = HandlebarsTemplates['challenge/balance']({result: result});
            $('#balance').html(compiledTemplate);
          });
      });
    });
  });

  // post to messages new
  function createMessage(id, c_id, data) {
    return $.ajax({
      method: 'post',
      url: "/users/" + id + "/challenges/" + c_id + "/messages",
      data: data
    });
  }

  // create new message on form submit
  $("#new-msg-form").on("submit", function(e){
    e.preventDefault();
    var message = {
      message: {
        text: $("#message_text").val(),
        is_private: $("#message_is_private").prop("checked"),
        is_caught: $("#message_is_caught").prop("checked"),
        is_invitation: $('#message_is_invitation').prop("checked"),
        msgpic: $('#message_msgpic').val(),
        challenge_id: challenge_id
      }
    };

    $.when(createMessage(user_id, challenge_id, message)).done(function(result){

      $("#message_text").val('');
      $("#message_is_private").val('');
      $("#message_is_caught").val('');
      $('#message_msgpic').val('');

      console.log("returned message: ", result)

      var compiledTemplate = HandlebarsTemplates['message/messages']({result: result});
      $('#msg-results').prepend(compiledTemplate);

      // add caught button click handler to new message
      $('#msg-results').first().find('.caught').click(function() {
        console.log('caught clicked')
        var $self = $(this)
        var msgId = $(this).attr('data-msgid');
        var userId = $(this).attr('data-userid')

        $.when(setConfirmed(userId, challenge_id, msgId)).done(function(result) {
          console.log(result);
          $self.css('opacity', '0');

          $.when(getChallenge(user_id, challenge_id)).done(function(result) {
            console.log("challenge result: ", result)
            var compiledTemplate = HandlebarsTemplates['challenge/balance']({result: result});
            $('#balance').html(compiledTemplate);
          });
        });

      });

    });
  });

  if($('body').hasClass('new')) {

    var getCharityCats = function() {
      var url = 'https://api.justgiving.com/4f937edd/v1/charity/categories';
        return $.getJSON(url, function() {});
      };
      var searchCharities = function(query) {
        var url = 'https://api.justgiving.com/4f937edd/v1/charity/search?{q}=' + query;
        return $.getJSON(url, function() {});
      };

      var getCharityByCatId = function(catId) {
        var url = 'https://api.justgiving.com/4f937edd/v1/charity/search?{categoryid}=' + catId;
        return $.getJSON(url, function() {});
      };

      var updateCharityResults = function() {
        $('#charity_cats').on('change', function() {
          console.log('charity cat selected')
          var catId = $(this).val();
          console.log(catId)
          $.when(getCharityByCatId(catId)).done(function(result) {
            console.log(result)
            var compiledTemplate = HandlebarsTemplates['challenge/charity_results']({result: result});
            $('#charity_results').html(compiledTemplate);
            $('.charity-result').click(function() {
              var curr_res = $(this).attr('data-id');
              var name = $(this).text();
              console.log(curr_res)
              $('#challenge_charity').val(curr_res);
              $('#charity_search').val(name);
            });
          });
        });
      };

      $('#challenge_charity').on('change', function() {
        var query = $(this).val();

        $.when(getCharities(query)).done(function(result) {
          console.log(result)
        });
      });

      $.when(getCharityCats()).done(function(result){
        console.log(result)
        var compiledTemplate = HandlebarsTemplates['challenge/charity_cats']({result: result});
          $('#charity_cats').html(compiledTemplate);

          updateCharityResults();
      });
    }
  }

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















