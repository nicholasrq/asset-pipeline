(function() {
  var OS, Path, Plugins, RSVP;

  OS = require('os');

  RSVP = require('rsvp');

  Path = require('path');

  Plugins = require('./plugins');

  module.exports.AssetPipeline = (function() {
    function AssetPipeline() {
      console.log('hello');
    }

    return AssetPipeline;

  })();

}).call(this);
