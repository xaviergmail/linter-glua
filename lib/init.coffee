{CompositeDisposable} = require('atom')

@config =
  executable:
    type: 'string'
    default: 'gluac'
    description: 'The executable path to gluac'

  scope:
    type: 'string'
    default: 'file'
    description: 'Lint entire project or just current file. Options: \'file\', \'project\''

@activate = =>
  @subscriptions = new CompositeDisposable
  @subscriptions.add atom.config.observe 'linter-glua.executable', (executable) =>
    @executablePath = executable

  @subscriptions.add atom.config.observe 'linter-glua.scope', (scope) =>
    @scope = scope

@deactivate = =>
  @subscriptions.dispose()

@provideLinter = ->
  regex = '^.+?:.+?:' +
      '(?<line>\\d+):\\s+' +
      '(?<message>.+?' +
      '(?:near (?<near>\'.+\')|$))'
  helpers = require('atom-linter')
  provider =
    grammarScopes: ['source.lua']
    scope: @scope
    lintOnFly: @scope isnt 'project'
    lint: (textEditor) =>
      new Promise (resolve, reject) =>
        parameters = ['-p', textEditor.getPath()]
        helpers.exec(@executablePath, parameters, {stream: 'stdout'}).then (output) ->
          helpers.parse(output, regex, filePath: textEditor.getPath()).map (error) ->
            error.type = 'Error'
            resolve [error]
