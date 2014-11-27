http = require 'http'
zlib = require 'zlib'
url  = require 'url'

class Server

  constructor: (env, @compiler)->

  compile: (path)->

  handle: (req, res)->
    pathname = url.parse(req.url).pathname
    
    console.log "Get #{pathname}"

    try
      pathname = decodeURIComponent(pathname.replace(/^\//, ''))
    catch e
      @request_end(res, 404)

    return @request_end(res, 403) if pathname.indexOf('..') >= 0
    return @request_end(res, 403) if pathname.indexOf('\u0000') >= 0
    return @request_end(res, 403) unless req.method in ['GET', 'HEAD']

    @compiler.do_compile(pathname).then(=>
      @request_end(res, 200)
    ).catch(=>
      @request_end(res, 500)
    )

  request_end: (response, code)->
    response.writeHead(code)
    if code >= 400
      response.end("[#{code}] #{http.STATUS_CODES[code]}")
    else
      response.end()

  @create: (env, compiled)->
    return new Server(env, compiled)

module.exports = Server
