App.users = App.cable.subscriptions.create "UsersChannel",
  disconnect: ->
    #alert('end follow')
    @perform 'unfollow'

  received: (data) ->
    switch data.action
      when "newUser"
        $('#users-board').append(data.message)
      when "newMessage"
        if data.currentUser is window.App.Data.currentUser
          $('#message-board').append("<div style=\"color: dodgerblue\">" + data.message + "</p>")
        else
          $('#message-board').append(data.message)

  followUsersChange: ->
    # Wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      #alert('follow users')
      @perform 'follow', {messageId: 'userChange'}
    , 1000

  followConversationsChange: ->
    # Wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      #alert('follow message')
      if window.App.Data.groupId.length > 0
        @perform 'follow', messageId: window.App.Data.groupId
    , 1000
