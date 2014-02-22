extend = ->
  _slice = Array::slice
  if Object::toString.call(arguments[0]) == '[object Boolean]'
    deep   = arguments[0]
    dest   = arguments[1]
    srcs   = _slice.call(arguments, 2)
  else
    deep   = false
    dest   = _slice.call(arguments, 0, 1)[0]
    srcs   = _slice.call(arguments, 1)

  srcs.forEach (src)->
    return true unless src?
    Object.keys(src).forEach (key)->
      unless deep
        dest[key] = src[key]
      else
        dest_type = Object::toString.call(dest[key])
        src_type  = Object::toString.call(src[key])
        if dest_type == '[object Object]'
          if src_type == '[object Object]'
            dest[key] = extend(deep, dest[key], src[key])
        else if dest_type == '[object Array]'
          if src_type == '[object Array]'
            dest[key] = dest[key].concat(src[key])
        else
          dest[key] = src[key]
  return dest

module.exports = extend
