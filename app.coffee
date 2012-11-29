express = require 'express'
fs = require 'fs'
async = require 'async'

app = module.exports = express.createServer()

app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + '/public')

app.configure ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

process.on 'uncaughtException', (er) ->
  console.log "Uncaught exception: #{er.message}"
  console.log er

fnameFromUrl = (url) ->
  url.substring(0, (if (url.indexOf("#") is -1) then url.length else url.indexOf("#")))
  url = url.substring(0, (if (url.indexOf("?") is -1) then url.length else url.indexOf("?")))
  url = url.substring(url.lastIndexOf("/") + 1, url.length)
  url

app.get '/', (req, res) ->
  res.render 'index.html'

app.listen 3000
console.log "Express server listening"

nowjs = require 'now'
everyone = nowjs.initialize app

mydir = ''
currdir = ''

addstat = (file, callback) ->
  fs.stat mydir + file, (err, stats) ->
    ret =
      name: file
      stats: stats
      isDirectory: stats.isDirectory()
      
    callback undefined, ret

fileordir = (dir, files, callback) ->
  mydir = dir
  if mydir is '.' then mydir = './'
  async.map files, addstat, (err, results) ->
    callback results

everyone.now.listFiles = (dir, callback) ->
  currdir = dir
  fs.readdir dir, (err, files) ->
    fileordir dir, files, callback  



