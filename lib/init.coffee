{CompositeDisposable} = require('atom')

@config =
  executable:
    type: 'string'
    default: 'gluac'
    description: "The executable path to gluac. Make sure 'tier0.dll' and 'lua_shared.dll' are in the same directory as the executable! Leave as 'gluac' if gluac.exe is on your system\'s PATH."

  scope:
    type: 'string'
    default: 'File'
    enum: ['File', 'Project']
    description: 'Lint entire project or just current file.'

  lintOnSave:
    type: 'boolean'
    default: false
    description: "Lint only on file save and not while typing. Defaults to true when Scope is set to 'project'"

@activate = =>
  @subscriptions = new CompositeDisposable
  @subscriptions.add atom.config.observe 'linter-glua.executable', (executable) =>
    @executablePath = executable

  @subscriptions.add atom.config.observe 'linter-glua.scope', (scope) =>
    @scope = scope or 'File'

  @subscriptions.add atom.config.observe 'linter-glua.lintOnSave', (save) =>
    @lintOnSave = save

@deactivate = =>
  @subscriptions.dispose()

@provideLinter = =>
  regex = '^.+?:.+?:' +
      '(?<line>\\d+):\\s+' +
      '(?<message>.+?' +
      '(?:near (?<near>\'.+\')|$))'
  helpers = require('atom-linter')
  provider =
    grammarScopes: ['source.lua']
    scope: @scope.toLowerCase()
    lintOnFly: if @scope is 'project' then false else not @lintOnSave
    lint: (textEditor) =>
      new Promise (resolve, reject) =>
        parameters = ['-p', textEditor.getPath()]
        helpers.exec(@executablePath, parameters, {stream: 'stdout'}).then (output) ->
          err = helpers.parse(output, regex, filePath: textEditor.getPath())
          if err.length
              err[0].type = 'Error'
              err[0].range[1][1] = Infinity
              resolve [err[0]]
          else
            resolve []
