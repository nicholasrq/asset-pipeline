(function() {
  var add;

  add = function() {
    var dest, source, _slice;
    _slice = [].slice;
    dest = arguments[0];
    source = _slice.call(arguments, 1);
    source.forEach(function(src) {
      if (Object.prototype.toString.call(src) === '[object Array]') {
        return dest = dest.concat(src);
      } else {
        return dest.push(src);
      }
    });
    return dest;
  };

  module.exports = add;

}).call(this);
