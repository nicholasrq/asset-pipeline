(function() {
  var AssetPipeline, OS, Path, Plugins, RSVP, Utils, env, root, snockets;

  OS = require('os');

  RSVP = require('rsvp');

  Path = require('path');

  Utils = require('./utils');

  Plugins = require('./plugins');

  snockets = new require('snockets');

  env = process.env.NODE_ENV;

  root = __dirname;

  AssetPipeline = (function() {
    AssetPipeline.prototype.plugins = {};

    AssetPipeline.prototype.defaults = {
      static_assets: Path.join(root, '..', '..', '..', 'public', 'assets'),
      assets_path: '/assets',
      assets_dir: ['assets'],
      auto_precompile_ext: ['.prod'],
      precompile_files: [],
      precompile: env === 'production'
    };

    AssetPipeline.prototype.set_app = function(exapp) {
      this.exapp = exapp;
      if (env !== 'production') {
        console.log("Asset Pipleine now listens for requests on " + this.options.assets_path);
        return this.exapp.use(this.options.assets_path, this.listen());
      } else {
        console.log("Asset Pipleine now serves static assets on " + this.options.static_assets);
        return this.exapp.use(this.options.assets_path, this.options.static_assets);
      }
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
      this.options = Utils.extend(true, {}, this.defaults, this.options, options);
      return this.assets = '';
    };

    AssetPipeline.prototype.will_precompile = function(files) {
      return Utils.add(this.options.precompile_files, files);
    };

    AssetPipeline.prototype.do_compile = function(asset_path) {
      return new RSVP.Promise((function(resolve, reject) {
        return resolve('yay!');
      }).bind(this));
    };

    AssetPipeline.prototype.listen = function() {
      var Server;
      Server = require('./modules/server');
      this.observer = Server.create(env, this);
      return this.observer;
    };

    AssetPipeline.prototype.middleware = function() {
      var astppl;
      astppl = this;
      return function(req, res, next) {
        res.locals = Utils.extend(res.locals, astppl.helpers);
        return next();
      };
    };

    return AssetPipeline;

  })();

  module.exports = new AssetPipeline;

}).call(this);
