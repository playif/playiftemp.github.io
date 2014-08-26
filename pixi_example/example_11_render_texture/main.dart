
import "dart:html";
import "dart:math";
import "../../lib/pixi.dart" as PIXI;


main() {
  // create an new instance of a pixi stage
  var stage = new PIXI.Stage(0x000000);

  // create a renderer instance
  var renderer = PIXI.autoDetectRenderer(800, 600);
  //var renderer =  new PIXI.CanvasRenderer(800, 600);

  // set the canvas width and height to fill the screen
  renderer.view.style.width = "${window.innerWidth}px";
  renderer.view.style.height = "${window.innerHeight}px";
  renderer.view.style.display = "block";

  // add render view to DOM
  document.body.append(renderer.view);
  renderer.view.style.display = "block";
  // OOH! SHINY!
  // create two render textures.. these dynamic textures will be used to draw the scene into itself
  var renderTexture = new PIXI.RenderTexture(800, 600);
  var renderTexture2 = new PIXI.RenderTexture(800, 600);
  var currentTexture = renderTexture;

  // create a new sprite that uses the render texture we created above
  var outputSprite = new PIXI.Sprite(currentTexture);

  // align the sprite
  outputSprite.position.x = 800 / 2;
  outputSprite.position.y = 600 / 2;
  outputSprite.anchor.x = 0.5;
  outputSprite.anchor.y = 0.5;

  // add to stage
  stage.addChild(outputSprite);

  var stuffContainer = new PIXI.DisplayObjectContainer();

  stuffContainer.position.x = 800 / 2;
  stuffContainer.position.y = 600 / 2;

  stage.addChild(stuffContainer);

  // create an array of image ids..
  var fruits = ["spinObj_01.png", "spinObj_02.png",
  "spinObj_03.png", "spinObj_04.png",
  "spinObj_05.png", "spinObj_06.png",
  "spinObj_07.png", "spinObj_08.png"];

  // create an array of items
  var items = [];

  Random random = new Random();
  // now create some items and randomly position them in the stuff container
  for (var i = 0; i < 10; i++) {
    PIXI.Sprite item = PIXI.Sprite.fromImage(fruits[i%fruits.length]);
    item.position.x = random.nextInt(400) - 200;
    item.position.y = random.nextInt(400) - 200;

    item.anchor.x = 0.5;
    item.anchor.y = 0.5;


    stuffContainer.addChild(item);

    items.add(item);
  }


  // used for spinning!
  var count = 0;


  animate(dt) {
    PIXI.requestAnimFrame(animate);


    for (var i = 0; i < items.length; i++) {
      // rotate each item
      var item = items[i];
      item.rotation += 0.1;
    }


    count += 0.01;

    // swap the buffers..
    var temp = renderTexture;
    renderTexture = renderTexture2;
    renderTexture2 = temp;


    renderTexture.render(stage,new PIXI.Point(0, 0), true);
    // set the new texture
    outputSprite.setTexture(renderTexture);

    // twist this up!
    stuffContainer.rotation -= 0.01;
    outputSprite.scale.x = outputSprite.scale.y = 1 + sin(count) * 0.2;

    // render the stage to the texture
    // the true clears the texture before content is rendered
    renderTexture2.render(stage, new PIXI.Point(0, 0), false);

    // and finally render the stage
    renderer.render(stage);


  }

  PIXI.requestAnimFrame(animate);
}
