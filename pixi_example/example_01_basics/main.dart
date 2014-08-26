import "dart:html";

import "../../lib/pixi.dart" as PIXI;

main() {

//  window.console.log(window.navigator.userAgent);
//  window.console.log(window.navigator.appCodeName);
//  window.console.log(window.navigator.appName);
//  window.console.log(window.navigator.appVersion);
//  window.console.log(window.navigator.maxTouchPoints);

  // create an new instance of a pixi stage
  var stage = new PIXI.Stage(0x660099);

  // create a renderer instance
  //var renderer =  new PIXI.CanvasRenderer(200, 200);
  //var renderer = new PIXI.WebGLRenderer(200, 200);
  var renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight);


  // add the renderer view element to the DOM
  document.body.append(renderer.view);

  renderer.view.style.display = "block";
  //renderer.view.style.width="${window.innerWidth}px";
  //renderer.view.style.height="${window.innerHeight}px";


  // create a texture from an image path
  var texture = PIXI.Texture.fromImage("bunny.png");
  //window.console.log(texture.baseTexture);
  // create a new Sprite using the texture


  var bunny = new PIXI.Sprite(texture);

  //Random random = new Random();
  //bunny.tint = random.nextInt(0xFFFFFF);

  // center the sprites anchor point
  bunny.anchor.x = 0.5;
  bunny.anchor.y = 0.5;

  // move the sprite t the center of the screen
  bunny.position.x = 100;
  bunny.position.y = 100;

  stage.addChild(bunny);


  //window.console.log(window.navigator.requestMidiAccess());

  animate(num delta) {
    PIXI.requestAnimFrame(animate);

    // just for fun, let's rotate mr rabbit a little
    bunny.rotation += 0.1;

    // render the stage
    renderer.render(stage);
  }
  PIXI.requestAnimFrame(animate);

}