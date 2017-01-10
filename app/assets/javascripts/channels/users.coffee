jQuery(document).on 'turbolinks:load', ->
  avatars = $('.user-avatar')


  if avatars.length > 0
    App.avatars = {}
    avatars.each ->
      avatar = $(this)
      App.avatars[avatar.data('user')] = App.cable.subscriptions.create {
          channel: "UsersOnlineChannel"
          user_id: avatar.data('user')
        },
        connected: ->
          # Called when the subscription is ready for use on the server

        disconnected: ->
          # Called when the subscription has been terminated by the server

        received: (data) ->
          avatar.html data['user']
