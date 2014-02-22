fs    = require 'fs'
Path  = require 'path'

files = (dir)->
  return [] unless fs.existsSync(dir)
  list    = fs.readdirSync(dir)
  result  = list.reduce(((arr, item)->
    path = Path.join( dir, item )
    stat = fs.lstatSync(path)
    if stat.isFile()
      arr.push path
    else
      unless stat.isSymbolicLink()
        arr = arr.concat(files(path))
    return arr
  ), [])
  return result

module.exports = files
