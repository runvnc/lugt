var asset = Asset.fromURL('http://localhost:3000/korg.wav');
asset.get('duration', function(duration) {
    // do something
  console.log('duration is ' + duration);
 });


asset.on('decodeStart', function() {
  var list = new BufferList;
  
  asset.on('data', function(buffer) {
    var buf = new Buffer(buffer);
    console.log(buf);
    list.push(buf);
    asset.decoder.readChunk();
  });

  asset.decoder.readChunk();
});

asset.start();
