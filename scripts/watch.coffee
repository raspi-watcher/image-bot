path = require 'path'
exec = require('child_process').exec
sudo = require 'sudo'
sprintf = require('sprintf-js').sprintf

module.exports = (robot) ->

  robot.respond /watch/i, (res) ->
    res.reply "this is " + robot.name + "'s camera."

    dir_path = "/media/Seagate Expansion Drive/raspi-watcher/image-bot-storage"

    now = new Date()
    year = sprintf("%04d", now.getFullYear())
    file_name = year + ".jpg"

    file_path = path.join dir_path, file_name
    console.log file_path

    options =
      cachePassword: true
      prompt: 'Password, yo? '
      # spawnOptions: { /* other options for spawn */ }

    motion_stop_cmd = [ 'service', 'motion', 'stop' ]
    raspistill_cmd = "raspistill -o '" + file_path + "'"
    slackcat_cmd = "slackcat -c camera " + file_path
    motion_start_cmd = [ 'service', 'motion', 'start' ]

    motion_stop_child_process = sudo motion_stop_cmd, options
    motion_stop_child_process.stdout.on 'data', (data) ->
      console.log data.toString()

    motion_stop_child_process.on 'close', (code, signal) ->

      res.reply file_path
      slackcat_child_process = exec raspistill_cmd, (error, stdout, stderr) ->
        if error != null
          console.log 'exec error: ' + error

        motion_start_child_process = sudo motion_start_cmd, options
        motion_start_child_process.stdout.on 'data', (data) ->
          console.log data.toString()

