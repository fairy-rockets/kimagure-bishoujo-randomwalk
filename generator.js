(function(){
  function uniformToNormal(u, v) {
    return Math.sqrt( -2.0 * Math.log( u ) ) * Math.cos( 2.0 * Math.PI * v );
  }
  var gan = new GAN();
  var noise = new Array(128).fill(0);
  var label = new Array(34).fill(0);
  gan.init().then(function() {
    gan.run(label, noise).then(function(result) {
      console.log(ImageEncoder.encode(result));
    });
  });
})();