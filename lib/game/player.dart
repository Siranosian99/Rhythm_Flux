import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';

class Player extends SpriteComponent with TapCallbacks {
  Player({super.position}) :
        super(size: Vector2.all(150), anchor: Anchor.center );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('spaceman.png');
  }

  @override
  void onTapUp(TapUpEvent info) {
    size += Vector2.all(50);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= 100 * dt;
  }
}