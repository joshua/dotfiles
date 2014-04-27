NumbersOnAPaneView = require './numbers-on-a-pane-view'

module.exports =
  numbersOnAPaneView: null

  activate: (state) ->
    @numbersOnAPaneView = new NumbersOnAPaneView(state.numbersOnAPaneViewState)

  deactivate: ->
    @numbersOnAPaneView.destroy()

  serialize: ->
    numbersOnAPaneViewState: @numbersOnAPaneView.serialize()
