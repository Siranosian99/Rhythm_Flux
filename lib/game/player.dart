import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:rhythm_flux/game/game_screen.dart';

class Player extends SpriteComponent with TapCallbacks , HasGameRef<MyGame>{
  Player({super.position}) :
        super(size: Vector2.all(150), anchor: Anchor.center );
  double speed = -100; // yukarı gidiyor

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('spaceman.png');
  }

  @override
  void onTapUp(TapUpEvent info) {
    // size += Vector2.all(50);
    speed  += speed++;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y+= speed * dt;
    if(position.y - size.y / 2 <=0){
      position.y = size.y / 2;
      speed = 100;
    }
    if(position.y + size.y / 2 >= gameRef.size.y){
      position.y = gameRef.size.y - size.y / 2;
      speed= -100;
    }
    }
}