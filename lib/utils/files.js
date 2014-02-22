(function() {
  var Path, files, fs;

  fs = require('fs');

  Path = require('path');

  files = function(dir) {
    var list, result;
    if (!fs.existsSync(dir)) {
      return [];
    }
    list = fs.readdirSync(dir);
    result = list.reduce((function(arr, item) {
      var path, stat;
      path = Path.join(dir, item);
      stat = fs.lstatSync(path);
      if (stat.isFile()) {
        arr.push(path);
      } else {
        if (!stat.isSymbolicLink()) {
          arr = arr.concat(files(path));
        }
      }
      return arr;
    }), []);
    return result;
  };

  module.exports = files;

}).call(this);
