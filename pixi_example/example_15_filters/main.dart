import "dart:html";
import "dart:math";
import "../../lib/pixi.dart" as PIXI;

main() {

  var renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight);
  renderer.view.style.display = "block";
  // create an new instance of a pixi stage
  var stage = new PIXI.Stage(0xFFFFFF, true);

  stage.interactive = true;

  var bg = PIXI.Sprite.fromImage("BGrotate.jpg");
  bg.anchor.x = 0.5;
  bg.anchor.y = 0.5;

  bg.position.x = 620 / 2;
  bg.position.y = 380 / 2;

  var colorMatrix = [1, 0, 0, 0,
  0, 1, 0, 0,
  0, 0, 1, 0,
  0, 0, 0, 1];

  var texture = PIXI.Texture.fromImage("panda.png");
  var displacementTexture = PIXI.Texture.fromImage("displacementMAP.jpg");
  var displacementFilter = new PIXI.RGBSplitFilter();
  //displacementFilter.scale = new Point(50, 50);

  //displacementFilter.size=new Point(10,10);
  //displacementFilter.angle=1;

  var filter = new PIXI.CrossHatchFilter();
  filter.blur = 10.2;
  //filter.map
  var filter2 = new PIXI.BlurFilter();
  filter2.blur = 100;

  var container = new PIXI.DisplayObjectContainer();
  container.position.x = 620 / 2;
  container.position.y = 380 / 2;

  var bgFront = PIXI.Sprite.fromImage("SceneRotate.jpg");
  bgFront.anchor.x = 0.5;
  bgFront.anchor.y = 0.5;

  container.addChild(bgFront);

  var light2 = PIXI.Sprite.fromImage("LightRotate2.png");
  light2.anchor.x = 0.5;
  light2.anchor.y = 0.5;
  container.addChild(light2);

  var light1 = PIXI.Sprite.fromImage("LightRotate1.png");
  light1.anchor.x = 0.5;
  light1.anchor.y = 0.5;
  container.addChild(light1);

  var panda = PIXI.Sprite.fromImage("panda.png");
  panda.anchor.x = 0.5;
  panda.anchor.y = 0.5;

  container.addChild(panda);

  stage.addChild(container);

  // create a renderer instance
  renderer.view.style.position = "absolute";
  renderer.view.style.width = "${window.innerWidth}px";
  renderer.view.style.height = "${window.innerHeight}px";
  renderer.view.style.display = "block";

  // add render view to DOM
  document.body.append(renderer.view);

  stage.filters = [displacementFilter];

  var count = 0;
  var switchy = false;

  stage.click = stage.tap = (e) {
    switchy = !switchy;

    if (!switchy) {
      stage.filters = [filter];
    }
    else {
      stage.filters = null;
    }
  };

//  // Add a pixi Logo!
//  var logo = PIXI.Sprite.fromImage("../../logo_small.png");
//
//  logo.anchor.x = 1;
//  logo.position.x = 620;
//  logo.scale.x = logo.scale.y = 0.5;
//  logo.position.y = 320;
//  logo.interactive = true;
//  logo.buttonMode = true;
//
//  logo.click = (e) {
//    window.open("https://github.com/GoodBoyDigital/pixi.js", "_blank");
//  };

  var help = new PIXI.Text("Click to turn filters on / off.", new PIXI.TextStyle()
    ..font = "bold 12pt Arial"
    ..fill = "white"
  );
  help.position.y = 350;
  help.position.x = 10;
  stage.addChild(help);

  animate(dt) {
    bg.rotation += 0.01;
    bgFront.rotation -= 0.01;

    light1.rotation += 0.02;
    light2.rotation += 0.01;

    panda.scale.x = 1 + sin(count) * 0.04;
    panda.scale.y = 1 + cos(count) * 0.04;

    count += 0.1;

    colorMatrix[1] = sin(count) * 3;
    colorMatrix[2] = cos(count);
    colorMatrix[3] = cos(count) * 1.5;
    colorMatrix[4] = sin(count / 3) * 2;
    colorMatrix[5] = sin(count / 2);
    colorMatrix[6] = sin(count / 4);
    //filter.matrix = colorMatrix;

    renderer.render(stage);
    PIXI.requestAnimFrame(animate);
  }

  PIXI.requestAnimFrame(animate);
}
