module.exports = {
  extensions: ['coffee', 'js.coffee']
  has_outdated: (path)->
    return new Promise((resolve, reject)->
      Snockets = require 'snockets'
      snockets = new Snockets
      snockets.scan(path, (err, dep)->
        unless err? then resolve(dep) else reject(err)
      )
    ).then((dep)->
      outdated = dep.map (file)->
        
    ).catch((err)-> console.error(err.stack))

  compile: (path)->
    return new Promise((resolve, reject)->
      Snockets = require 'snockets'
      snockets = new Snockets
      snockets.getConcatenation(path, (err, compiled)->
        unless err? then resolve(compiled) else reject(err)
      )
    ).catch((err)-> console.error(err.stack))
}
