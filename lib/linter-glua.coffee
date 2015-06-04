linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

class LinterLua extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: 'source.lua'

  linterName: 'gluac'

  # A regex pattern used to extract information from the executable's output.
  regex:
    '^.+?:.+?:' +
    '(?<line>\\d+):\\s+' +
    '(?<message>.+?' +
    '(?:near (?<near>\'.+\')|$))'

  errorStream: 'stdout'

  constructor: (editor) ->
    super(editor)

    # Set to observe config options
    @configSubscription = atom.config.observe 'linter-glua.executable', => @updateCommand()

  updateCommand: ->
    executable = atom.config.get 'linter-glua.executable'
    console.log executable
    @cmd = [executable, '-p']

  destroy: ->
    super
    @configSubscription.dispose()

module.exports = LinterLua
