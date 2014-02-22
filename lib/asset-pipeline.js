(function() {
  var AssetPipeline, OS, Path, Plugins, RSVP, Utils, app_root, env, root, snockets;

  OS = require('os');

  RSVP = require('rsvp');

  Path = require('path');

  Utils = require('./utils');

  Plugins = require('./plugins');

  snockets = new require('snockets');

  env = process.env.NODE_ENV;

  root = __dirname;

  app_root = Path.join(root);

  AssetPipeline = (function() {
    AssetPipeline.prototype.plugins = {};

    AssetPipeline.prototype.defaults = {
      static_assets: Path.join(app_root, 'public', 'assets'),
      assets_path: '/assets',
      assets_dir: [Path.join(app_root, 'assets'), Path.join(app_root, 'vendor'), Path.join(app_root, 'lib')],
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
      this.compiler = require('./modules/compiler');
      this.configure(options);
    }

    AssetPipeline.prototype.configure = function(options) {
      if (options == null) {
        options = {};
      }
      this.options = Utils.extend({}, this.defaults, this.options, options);
      this.assets = require('./modules/watch_assets');
      this.assets.set_dir(this.options.assets_dir);
      if (!this.options.precompile) {
        return this.assets.live();
      } else {
        return this.assets.index();
      }
    };

    AssetPipeline.prototype.will_precompile = function(files) {
      return Utils.add(this.options.precompile_files, files);
    };

    AssetPipeline.prototype.do_compile = function(asset_path) {
      return new RSVP.Promise((function(resolve, reject) {
        return this.assets.find(asset_path).then(this.compiler.process).then(function(err, data) {
          if (typeof error === "undefined" || error === null) {
            return resolve(data);
          } else {
            return reject();
          }
        })["catch"](function(err) {
          return reject(err);
        });
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
