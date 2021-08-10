module test;

import raylib_c3;

import std::io;

func int main() {
  raylib_c3::init_window(800, 400, "example");

  raylib_c3::set_target_fps(144);
  while(!raylib_c3::window_should_close()) {
    raylib_c3::begin_drawing();
      raylib_c3::clear_background(Color({ 245, 245, 245, 255 }));
      raylib_c3::draw_text("Raylib running from C3!", 190, 200, 20, Color({ 80, 80, 80, 255 }));
    raylib_c3::end_drawing();
  }
  return 0;
}