import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent {
  Background.create(Viewport viewport) {
    resize(viewport);
    // sprite = Sprite(ImageTool.image(Levels.background));
  }

  void resize(Viewport viewport) {
    width = viewport.size.x;
    height = viewport.size.y;
  }
}
