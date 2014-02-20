merge = ->
  _slice = [].slice
  if (deep = arguments) instanceof Boolean
    dest   = _slice(arguments, 1,1)
    src    = _slice(arguments, 2)
  else
    dest   = _slice(arguments, 0,1)
    src    = _slice(arguments, 1)

  Object.keys(src).forEach (key)->
    unless deep
      dest[key] = src[key]
    else
      dest_type = Object::toString(dest[key])
      src_type  = Object::toString(src[key])
      if obj_type == '[object Object]'
        dest[key] = merge(deep, dest[key], src[key]) if src_type == '[object Object]'
      else if obj_type == '[object Array]'
        dest[key] = dest[key].concat(src[key]) if src_type == '[object Array]'
      else
        dest[key] = src[key]
  return dest

module.exports = merge
