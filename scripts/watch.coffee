path = require 'path'
exec = require('child_process').exec

module.exports = (robot) ->

  robot.respond /watch/i, (res) ->
    res.reply "this is " + robot.name + "'s camera."

    filepath = path.join __dirname, '..', 'README.md'
    console.log filepath
    res.reply filepath

    child = exec "slackcat -c general " + filepath, (error, stdout, stderr) ->
      console.log 'stdout: ' + stdout
      console.log 'stderr: ' + stderr
      if error != null
        console.log 'exec error: ' + error
