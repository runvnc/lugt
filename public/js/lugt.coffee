
window.loadini = ->
  console.log 'clicked'
  now.loadini (data) ->
    console.log JSON.stringify(data)

asset = null

loadwav = (url) ->
  console.log 'loading wave'
  $.get url
  asset = Asset.fromURL url

  asset.get 'duration', (duration) ->
    console.log 'duration is ' + duration

  asset.on 'decodeStart', ->
    console.log 'decodestart'
    list = new BufferList
    
    asset.on 'data', (buffer) ->
      console.log 'received some data'
      buf = new Buffer(buffer)
      list.push buf
      console.log buf
      asset.decoder.readChunk()

    asset.decoder.readChunk()

  console.log 'starting'
  asset.start()

$ ->
  $('#load').click ->
    window.loadini()
  loadwav 'korg.wav'

   

