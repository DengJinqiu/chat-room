App.users = App.cable.subscriptions.create "UsersChannel",
  disconnect: ->
    setTimeout =>
      alert('unfollow')
      @perform 'unfollow'
    , 1000

  received: (data) ->
    switch data.action
      when "newUser"
        $('#users-board').append(data.message)
      when "newMessage"
        if data.currentUser is window.App.Data.currentUser
          $('#message-board').append("<div style=\"color: dodgerblue\">" + data.message + "</div>")
        else
          $('#message-board').append(data.message)

  followConversationsAndUsersChange: ->
    # Wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      if window.App.Data.groupId.length > 0
        @perform 'follow', messageId: window.App.Data.groupId
      else
        @perform 'follow', messageId: ''
    , 1000
