App.users = App.cable.subscriptions.create "UsersChannel",
  collection: -> $("[data-channel='users']")

  connected: ->
    # Wait cable subscriptions to finish before sending messages
    setTimeout =>
      @followUsersChange()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.name)

  followUsersChange: ->
    @perform 'follow', message_id: 'all_users'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.comments.followCurrentMessage()

App.conversations = App.cable.subscriptions.create "ConversationsChannel",
  collection: -> $("[data-channel='conversations']")

  connected: ->
    # Wait cable subscriptions to finish before sending messages
    setTimeout =>
      @followConversationsChange()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.name)

  followConversationsChange: ->
    @perform 'follow', message_id: window.App.Data.groupId

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.comments.followCurrentMessage()
