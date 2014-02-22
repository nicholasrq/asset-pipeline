(function() {
  var Server, http, url, zlib;

  http = require('http');

  zlib = require('zlib');

  url = require('url');

  Server = (function() {
    function Server(env, compiler) {
      this.compiler = compiler;
    }

    Server.prototype.compile = function(path) {};

    Server.prototype.handle = function(req, res) {
      var e, pathname, _ref;
      pathname = url.parse(req.url).pathname;
      try {
        pathname = decodeURIComponent(pathname.replace(/^\//, ''));
      } catch (_error) {
        e = _error;
        this.request_end(res, 404);
      }
      if (pathname.indexOf('..') >= 0) {
        return this.request_end(res, 403);
      }
      if (pathname.indexOf('\u0000') >= 0) {
        return this.request_end(res, 403);
      }
      if ((_ref = req.method) !== 'GET' && _ref !== 'HEAD') {
        return this.request_end(res, 403);
      }
      return this.compiler.do_compile(pathname).then((function(_this) {
        return function() {
          return _this.request_end(res, 200);
        };
      })(this))["catch"]((function(_this) {
        return function() {
          return _this.request_end(res, 500);
        };
      })(this));
    };

    Server.prototype.request_end = function(response, code) {
      response.writeHead(code);
      if (code >= 400) {
        return response.end("[" + code + "] " + http.STATUS_CODES[code]);
      } else {
        return response.end();
      }
    };

    Server.create = function(env, compiled) {
      return new Server(env, compiled);
    };

    return Server;

  })();

  module.exports = Server;

}).call(this);
