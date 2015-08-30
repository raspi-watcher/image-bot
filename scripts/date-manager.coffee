sprintf = require('sprintf-js').sprintf

module.exports =
class DateManager
  constructor: (date) ->
    @date = date

  toStringPlus: () ->
    y = sprintf "%04d", @date.getFullYear()
    m = sprintf "%02d", @date.getMonth() + 1
    d = sprintf "%02d", @date.getDate()
    h = sprintf "%02d", @date.getHours()
    mn = sprintf "%02d", @date.getMinutes()
    s = sprintf "%02d", @date.getSeconds()
    ms = sprintf "%04d", @date.getMilliseconds()
    return y + m + d + h + mn + s + ms
