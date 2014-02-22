add = ->
  _slice   = [].slice
  dest     = arguments[0]
  source   = _slice.call(arguments, 1)

  source.forEach (src)->
    if Object::toString.call(src) == '[object Array]'
      dest = dest.concat(src)
    else dest.push(src)
  return dest

module.exports = add
