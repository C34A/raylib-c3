module camera_3d;

import raylib_c3;

import std::io;

func void main() {
  const int WIDTH = 800;
  const int HEIGHT = 450;

  raylib_c3::set_config_flags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
  raylib_c3::init_window(WIDTH, HEIGHT, "example");

  Camera3D camera;
  camera.position   = Vector3({0.0, 10.0, 10.0}); // position
  camera.target     = Vector3({0.0, 0.0, 0.0});   // point at the origin
  camera.up         = Vector3({0.0, 1.0, 0.0});   // camera up vector
  camera.fovy       = 45.0;
  camera.projection = CameraProjection.CAMERA_PERSPECTIVE;

  Vector3 cubePosition = Vector3({0.0, 0.0, 0.0});

  raylib_c3::set_target_fps(60);
  while(!raylib_c3::window_should_close()) {
    raylib_c3::begin_drawing();
      raylib_c3::clear_background(RAYWHITE);

      // yeah this name needs fixing
      raylib_c3::begin_mode_3d(camera);

        raylib_c3::draw_cube(cubePosition, 2.0, 2.0, 2.0, RED);
        raylib_c3::draw_cube_wires(cubePosition, 2.0, 2.0, 2.0, MAROON);

        raylib_c3::draw_grid(10, 1.0);

      raylib_c3::end_mode_3d();

      raylib_c3::draw_text("Welcome to the third dimension!", 10, 40, 20, DARKGRAY);
      raylib_c3::draw_fps(10, 10);

    raylib_c3::end_drawing();
  }

  raylib_c3::close_window();
}
