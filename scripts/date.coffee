DateManager = require "./date-manager"

module.exports = (robot) ->

  robot.respond /date/i, (res) ->

    res.reply new DateManager(new Date()).toStringPlus()
