NumbersOnAPane = require '../lib/numbers-on-a-pane'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "NumbersOnAPane", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('numbersOnAPane')

  describe "when the numbers-on-a-pane:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.numbers-on-a-pane')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'numbers-on-a-pane:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.numbers-on-a-pane')).toExist()
        atom.workspaceView.trigger 'numbers-on-a-pane:toggle'
        expect(atom.workspaceView.find('.numbers-on-a-pane')).not.toExist()
