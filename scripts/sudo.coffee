sudo = require 'sudo'

module.exports = (robot) ->

  robot.respond /sudo/i, (res) ->

    dirpath = '/tmp'
    console.log dirpath
    res.reply dirpath

    options =
      cachePassword: true
      prompt: 'Password, yo? '
      # spawnOptions: { /* other options for spawn */ }

    cmd = [ 'ls', '-l', dirpath ]

    child = sudo cmd, options
    child.stdout.on 'data', (data) ->
      console.log data.toString()
      res.reply data.toString()
