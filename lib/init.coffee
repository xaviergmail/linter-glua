module.exports =
  config:
    executable:
      type: 'string'
      default: 'gluac'
      description: 'The executable path to gluac'

  activate: ->
    console.log 'activate linter-glua'
