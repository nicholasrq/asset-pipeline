(function() {
  var AssetPipeline, OS, Path, Plugins, RSVP, Utils, snockets;

  OS = require('os');

  RSVP = require('rsvp');

  Path = require('path');

  Utils = require('./utils');

  Plugins = require('./plugins');

  snockets = new require('snockets');

  AssetPipeline = (function() {
    AssetPipeline.prototype.plugins = {};

    AssetPipeline.prototype.defaults = {
      assets_dir: ['assets'],
      auto_precompile_ext: ['.prod'],
      precompile_files: [],
      precompile: process.env === 'production'
    };

    function AssetPipeline(options) {
      if (options == null) {
        options = {};
      }
      this.configure(options);
    }

    AssetPipeline.prototype.configure = function(options) {
      if (options == null) {
        options = {};
      }
      return this.options = Utils.extend(true, {}, this.defaults, this.options, options);
    };

    AssetPipeline.prototype.will_precompile = function(files) {
      return Utils.add(this.options.precompile_files, files);
    };

    AssetPipeline.prototype.do_precompile = function() {
      return console.log('I will precompile your assets!');
    };

    AssetPipeline.prototype.middleware = function() {
      var astppl;
      astppl = this;
      return function(req, res, next) {
        astppl.do_precompile(process.env);
        res.locals = Utils.extend(res.locals, astppl.helpers);
        return next();
      };
    };

    return AssetPipeline;

  })();

  module.exports = new AssetPipeline;

}).call(this);
