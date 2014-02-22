(function() {
  var extend;

  extend = function() {
    var deep, dest, srcs, _slice;
    _slice = Array.prototype.slice;
    if (Object.prototype.toString.call(arguments[0]) === '[object Boolean]') {
      deep = arguments[0];
      dest = arguments[1];
      srcs = _slice.call(arguments, 2);
    } else {
      deep = false;
      dest = _slice.call(arguments, 0, 1)[0];
      srcs = _slice.call(arguments, 1);
    }
    srcs.forEach(function(src) {
      if (src == null) {
        return true;
      }
      return Object.keys(src).forEach(function(key) {
        var dest_type, src_type;
        if (!deep) {
          return dest[key] = src[key];
        } else {
          dest_type = Object.prototype.toString.call(dest[key]);
          src_type = Object.prototype.toString.call(src[key]);
          if (dest_type === '[object Object]') {
            if (src_type === '[object Object]') {
              return dest[key] = extend(deep, dest[key], src[key]);
            }
          } else if (dest_type === '[object Array]') {
            if (src_type === '[object Array]') {
              return dest[key] = dest[key].concat(src[key]);
            }
          } else {
            return dest[key] = src[key];
          }
        }
      });
    });
    return dest;
  };

  module.exports = extend;

}).call(this);
