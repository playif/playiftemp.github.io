import "dart:html";
import "dart:math";
import "../../lib/pixi.dart" as PIXI;

main() {
  // create an new instance of a pixi stage
  var stage = new PIXI.Stage(0x97C56E, true);

  // create a renderer instance
  var renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight);
  //var renderer =  new PIXI.CanvasRenderer(window.innerWidth, window.innerHeight);
  // add the renderer view element to the DOM
  renderer.view.style.position = "absolute";
  renderer.view.style.top = "0px";
  renderer.view.style.left = "0px";
  document.body.append(renderer.view);

  // create a texture from an image path
  var texture = PIXI.Texture.fromImage("p2.jpeg");

  // create a tiling sprite ...
  // requires a texture, width and height
  // to work in webGL the texture size must be a power of two
  var tilingSprite = new PIXI.TilingSprite(texture, window.innerWidth, window.innerHeight);
  stage.addChild(tilingSprite);

  var count = 0;

  animate(dt) {
    count += 0.005;

    tilingSprite.tileScale.x = 1.2+sin(count);
    tilingSprite.tileScale.y = 1.2+cos(count);

    tilingSprite.tilePosition.x += 1;
    tilingSprite.tilePosition.y += 1;

    // render the stage
    renderer.render(stage);


    PIXI.requestAnimFrame(animate);
  }
  PIXI.requestAnimFrame(animate);
}