{View} = require 'atom'

module.exports =
class NumbersOnAPaneView extends View

  initialize: (serializeState) ->
    atom.workspaceView.command "numbers-on-a-pane:toggle", => @toggle()

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "Numbers On A Pane was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
