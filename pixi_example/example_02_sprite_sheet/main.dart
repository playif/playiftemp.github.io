import "dart:html";
import "dart:math";
import "../../lib/pixi.dart" as PIXI;

main() {
  // create an array of assets to load
  var assetsToLoader = [ "SpriteSheet.json" ];

  // holder to store aliens
  var aliens = [];
  var alienFrames = ["eggHead.png", "flowerTop.png", "helmlok.png", "skully.png"];
  int aliensCount = 100;
  num count = 0;

  // create an new instance of a pixi stage
  var stage = new PIXI.Stage(0xFFFFFF);

  // create a renderer instance.
  var renderer = PIXI.autoDetectRenderer(800, 600);
  //var renderer = new PIXI.CanvasRenderer(800, 600);

  // add the renderer view element to the DOM
  document.body.append(renderer.view);
  renderer.view.style.display = "block";
  // create an empty container
  var alienContainer = new PIXI.DisplayObjectContainer();
  alienContainer.position.x = 400;
  alienContainer.position.y = 300;

  stage.addChild(alienContainer);

  Random random = new Random();


  animate(num delta) {
    // just for fun, lets rotate mr rabbit a little
    for (var i = 0; i < aliensCount; i++) {
      var alien = aliens[i];
      alien.rotation += 0.1;
    }

    count += 0.01;
    alienContainer.scale.x = sin(count);
    alienContainer.scale.y = sin(count);

    alienContainer.rotation += 0.01;

    // render the stage
    renderer.render(stage);

    PIXI.requestAnimFrame(animate);
  }

  onAssetsLoaded() {

    // add a bunch of aliens with textures from image paths
    for (var i = 0; i < aliensCount; i++) {
      var frameName = alienFrames[i % 4];
      // create an alien using the frame name..
      var alien = PIXI.Sprite.fromFrame(frameName);
      alien.tint = random.nextInt(0xFFFFFF);

      /*
             * fun fact for the day :)
             * another way of doing the above would be
             * var texture = PIXI.Texture.fromFrame(frameName);
             * var alien = new PIXI.Sprite(texture);
             */
      alien.position.x = random.nextInt(800) - 400;
      alien.position.y = random.nextInt(600) - 300;
      alien.anchor.x = 0.5;
      alien.anchor.y = 0.5;
      aliens.add(alien);
      alienContainer.addChild(alien);
    }

    // start animating
    PIXI.requestAnimFrame(animate);
  }

  // create a new loader
  var loader = new PIXI.AssetLoader(assetsToLoader);

  // use callback
  loader.onComplete = onAssetsLoaded;

  //begin load
  loader.load();
}
