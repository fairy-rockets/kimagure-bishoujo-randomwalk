const chrome = require('chrome-remote-interface');

const fs = require('fs');
const src = fs.readFileSync("./generator.js", "utf8");
const output = fs.createWriteStream('./output.txt');
const dataurl = require('dataurl');

function init(Runtime) {
  return Runtime.evaluate({
    expression:`
      function uniformToNormal() {
        var u = 1 - Math.random();
        var v = 1 - Math.random();
        return Math.sqrt( -2.0 * Math.log( u ) ) * Math.cos( 2.0 * Math.PI * v );
      }
      function clamp(value, min, max) {
        return Math.min(Math.max(value, min), max);
      }
      var gan = new GAN();
      var noise = new Array(128).fill(0);
      var label = new Array(34).fill(0);
      gan.init();`,
    awaitPromise: true})
  .then((r) => { console.log("Init ok: ", r); return r; })
  .catch(err => console.log("Error on init: ", err))
}

function generate(Runtime) {
  return Runtime.evaluate({
    expression: `
      var scale = 0.01;
      for(var i=0;i<noise.length;i++) {
        noise[i] = clamp(noise[i] + uniformToNormal() * scale, -1, 1);
      }
      for(var i=0;i<label.length;i++){
        label[i] = clamp(label[i] + uniformToNormal() * scale, -1, 1);
      }
      gan.run(label, noise).then((result) => ImageEncoder.encode(result));`,
    awaitPromise: true})
}

function generateLoop(Runtime, i, max) {
  var startTime = new Date();
  return generate(Runtime).then(function(res) {
    console.log("Step: ", i ," / ", max," [", new Date()-startTime, " msec]")
    var r = dataurl.parse(res.result.value)
    const fname = ( "000000" + i ).substr(-7)
    output.write(res.result.value)
    output.write('\n')
  
    var next = new Promise(function(resolve, reject){
      fs.writeFile("img/"+fname+".png", r.data, (err) => {
        if(err){
          reject(err);
        }else{
          resolve();
        }
      })
    }).catch(err => console.error(err));
    if(i <= max){
      return next.then(() => generateLoop(Runtime, i+1, max));
    }else{
      return next;
    }
  });
}

var i = 0
chrome(protocol => {
  // DevTools プロトコルから、必要なタスク部分を抽出する。
  // API ドキュメンテーション: https://chromedevtools.github.io/devtools-protocol/
  const {Page, Runtime} = protocol;

  // まず、使用するドメインを有効にする。
  Promise.all([
    Page.enable(),
    Runtime.enable()
  ])
  .then(() => init(Runtime).then(() => generateLoop(Runtime, 0, 1000000000)))
  .then(() => protocol.close())
  .catch((err) => console.error(err));

}).on('error', err => {
  throw Error('Cannot connect to Chrome:' + err);
});

