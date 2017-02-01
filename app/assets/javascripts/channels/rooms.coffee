jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  chat_rooms = $('#chat-rooms')
  votes_container = $('.votes-container')

  detect_vote = ($this_votes_container, $this) ->
    return true unless $this_votes_container.attr('data-voted') is 'none'
    return true if $this_votes_container.attr('data-voted') is $this.data('vote')

  update_vote = ->
    $('.votes-container').each ->
      if $(this).data('voted') is 'hide'
        $(this).find('a').hide()

  update_vote()
  if messages.length > 0
    messages_to_bottom = -> messages.parents('.yeld-container').scrollTop(messages.prop("scrollHeight"))

    #messages_to_bottom()
    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: messages.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false


  if chat_rooms.length > 0
    App.index_room = App.cable.subscriptions.create {
        channel: "ChatRoomsIndexChannel"
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log data
        chat_rooms.prepend data['chat_room']


  if votes_container.length > 0
    App.votes = {}
    votes_container.each ->
      vote_container = $(this)
      App.votes[vote_container.data('chat-room-id')] = App.cable.subscriptions.create {
          channel: "VotesChannel"
          chat_room_id: vote_container.data('chat-room-id')
        },
        connected: ->
          # Called when the subscription is ready for use on the server

        disconnected: ->
          # Called when the subscription has been terminated by the server

        received: (data) ->
          vote_container.html data['vote']
          update_vote()

        send_message: (vote, chat_room_id) ->
          @perform 'send_message', vote: vote, chat_room_id: chat_room_id


    votes_container.on 'click', 'a', (e) ->
      $this = $(this)
      $this_votes_container = $this.parents('.votes-container')
      chat_room_id = $this_votes_container.data('chat-room-id')
      console.log $this_votes_container.attr('data-voted')
      console.log $this.data('vote')
      if detect_vote($this_votes_container, $this)
        $this_votes_container.attr('data-voted', 'none')
      else
        $this_votes_container.attr('data-voted', $this.data('vote'))
      App.votes[chat_room_id].send_message $this.data('vote'), chat_room_id
      e.preventDefault()
      return false
