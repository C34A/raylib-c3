module cubes;

import raylib_c3;

func void main() {
  const int WIDTH = 800;
  const int HEIGHT = 450;

  raylib_c3::set_config_flags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
  raylib_c3::init_window(WIDTH, HEIGHT, "Example - waving cubes");


  Camera3D camera;
  camera.position = Vector3({ 30.0, 20.0, 30.0 });
  camera.target = raylib_c3::vector3_zero();
  camera.up = Vector3({ 0.0, 1.0, 0.0 });
  camera.fovy = 70.0;
  camera.projection = CameraProjection.CAMERA_PERSPECTIVE;

  const int NUM_BLOCKS = 15;

  raylib_c3::set_target_fps(144);

  while (!raylib_c3::window_should_close()) {
    // Update
    double time = raylib_c3::get_time();

    // Calculate time scale for cube position and size
    float scale = (2.0 + (float)(sin(time))) * 0.7;

    double cameraTime = time*0.3;
    camera.position.x = (float)(cos(cameraTime)) * 40.0;
    camera.position.z = (float)(sin(cameraTime)) * 40.0;

    // Draw
    raylib_c3::begin_drawing();

      raylib_c3::clear_background(RAYWHITE);

      raylib_c3::begin_mode3_d(camera);

        raylib_c3::draw_grid(10, 5.0);

        for (int x = 0; x < NUM_BLOCKS; x++) {
          for (int y = 0; y < NUM_BLOCKS; y++) {
            for (int z = 0; z < NUM_BLOCKS; z++) {
              // Scale of the blocks depends on x/y/z positions
              float blockScale = (float)( (x + y + z) / 30.0 );

              float scatter = (float)( sin(blockScale*20.0 + (float)(time*4.0)) );

              Vector3 cubePos = Vector3({
                (float)(x - NUM_BLOCKS/2)*(scale*3.0) + scatter,
                (float)(y - NUM_BLOCKS/2)*(scale*2.0) + scatter,
                (float)(z - NUM_BLOCKS/2)*(scale*3.0) + scatter,
              });

              // Pick a color with a hue depending on cube position for the rainbow color effect
              Color cubeColor = raylib_c3::color_from_hsv(
                (float)( ( (x + y + z)*18 )%360 ),
                0.75,
                0.9,
              );

              // Calculate cube size
              float cubeSize = (2.4 - scale) * blockScale;

              // Finally, draw the cube!
              raylib_c3::draw_cube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor);
            }
          }
        }

      raylib_c3::end_mode3_d();

      raylib_c3::draw_fps(10, 10);

    raylib_c3::end_drawing();
  }

  raylib_c3::close_window();
}

extern func double sin(double x);
extern func double cos(double x);