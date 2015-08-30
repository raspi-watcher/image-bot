path = require 'path'
exec = require('child_process').exec
sudo = require 'sudo'

module.exports = (robot) ->

  robot.respond /watch/i, (res) ->
    res.reply "this is " + robot.name + "'s camera."

    # dirpath = '/tmp'
    # console.log dirpath

    filepath = path.join __dirname, '..', 'README.md'
    console.log filepath

    options =
      cachePassword: true
      prompt: 'Password, yo? '
      # spawnOptions: { /* other options for spawn */ }

    motion_stop_cmd = [ 'service', 'avahi-daemon', 'stop' ]
    slackcat_cmd = "slackcat -c general " + filepath
    motion_start_cmd = [ 'service', 'avahi-daemon', 'start' ]

    # res.reply dirpath
    motion_stop_child_process = sudo motion_stop_cmd, options
    motion_stop_child_process.stdout.on 'data', (data) ->
      console.log data.toString()
      res.reply data.toString()

      res.reply filepath
      slackcat_child_process = exec slackcat_cmd, (error, stdout, stderr) ->
        # res.reply stdout
        if error != null
          console.log 'exec error: ' + error

        # res.reply dirpath
        motion_start_child_process = sudo motion_start_cmd, options
        motion_start_child_process.stdout.on 'data', (data) ->
          console.log data.toString()
          res.reply data.toString()
