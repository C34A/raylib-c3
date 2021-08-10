module input_keys;

import raylib_c3;

func void main() {
  int screenWidth = 800;
  int screenHeight = 450;

  raylib_c3::init_window(screenWidth, screenHeight, "raylib c3 example - keyboard input");

  Vector2 ballPosition = Vector2({
    (float)(screenWidth/2),
    (float)(screenHeight/2),
  });

  raylib_c3::set_target_fps(144);

  while (!raylib_c3::window_should_close()) {
    if (raylib_c3::is_key_down(raylib_c3::KeyboardKey.KEY_RIGHT)) {
      ballPosition.x += 2.0f;
    }


    raylib_c3::begin_drawing();
      raylib_c3::clear_background(raylib_c3::RAYWHITE);
      raylib_c3::draw_text("move the ball with arrow keys", 10, 10, 20, raylib_c3::DARKGRAY);
      raylib_c3::draw_circle_v(ballPosition, 50, raylib_c3::MAROON);
    raylib_c3::end_drawing();
  }

  raylib_c3::close_window();
}