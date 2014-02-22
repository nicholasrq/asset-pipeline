(function() {
  var RSVP, Utils, WatchAssets;

  RSVP = require('rsvp');

  Utils = require('../utils');

  WatchAssets = (function() {
    var assets_index;

    assets_index = {
      assets: {},
      dependencies: {}
    };

    function WatchAssets() {
      this.dirs = [];
    }

    WatchAssets.prototype.live = function() {
      this.remove_listeners();
      this.add_listeners();
      return this.index();
    };

    WatchAssets.prototype.index = function() {
      return new RSVP.Promise(((function(_this) {
        return function(resolve, reject) {
          var files;
          files = _this.dirs.reduce((function(list, dir) {
            var files_list;
            files_list = Utils.files(dir).reduce((function(res, file_path) {
              var asset_path;
              asset_path = file_path.replace(dir + '/', '');
              res[asset_path] = file_path;
              return res;
            }), {});
            return list.concat(files_list);
          }), []);
          return resolve(files);
        };
      })(this))).then(this.save_index)["catch"](this.handle_errors);
    };

    WatchAssets.prototype.save_index = function(files) {};

    WatchAssets.prototype.add_listeners = function() {};

    WatchAssets.prototype.remove_listeners = function() {};

    WatchAssets.prototype.handle_errors = function(err) {
      return console.error(err.stack);
    };

    WatchAssets.prototype.set_dir = function(dirs) {
      if (typeof dirs === 'string') {
        return this.dirs = [dirs];
      } else if (Array.isArray(dirs)) {
        return this.dirs = dirs;
      }
    };

    return WatchAssets;

  })();

  module.exports = new WatchAssets;

}).call(this);
