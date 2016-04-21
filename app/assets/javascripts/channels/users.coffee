App.users = App.cable.subscriptions.create "UsersChannel",
  connected: ->
    # Wait cable subscriptions to finish before sending messages
    setTimeout =>
      @followConversationsChange()
      @followUsersChange()
    , 1000

  received: (data) ->
    switch data.action
      when "new_user"
        alert("user change")
        $('#users-board').append(data.message)
      when "new_message"
        alert("message change")
        eval(data.message)

  followUsersChange: ->
    alert("follow user")
    #@perform 'follow', {message_id: 'user_change'}
    @perform 'follow'
    @perform 'unfollow'

  followConversationsChange: ->
    if window.App.Data.groupId.length > 0
      alert("follow message")
      @perform 'follow', message_id: window.App.Data.groupId
