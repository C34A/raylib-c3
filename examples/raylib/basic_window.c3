module basic_window;

import raylib_c3;

func void main() {
  raylib_c3::init_window(800, 400, "example");

  raylib_c3::set_target_fps(60);

  while(!raylib_c3::window_should_close()) {
    raylib_c3::begin_drawing();
      raylib_c3::clear_background(RAYWHITE);
      raylib_c3::draw_text("Raylib running from C3!", 190, 200, 20, DARKGRAY);
    raylib_c3::end_drawing();
  }
}