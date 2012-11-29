asset = Asset.fromURL 'http://localhost:3000/korg.wav'

asset.get 'duration', (duration) ->
  console.log 'duration is ' + duration

asset.on 'decodeStart', ->
  list = new BufferList
  
  asset.on 'data', (buffer) ->
    buf = new Buffer(buffer)
    list.push buf
    asset.decoder.readChunk()

  asset.decoder.readChunk()

asset.start()


