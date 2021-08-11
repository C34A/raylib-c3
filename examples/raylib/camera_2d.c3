module camera_2d;

import raylib_c3;

const int MAX_BUILDINGS = 100;

func void main() {
  const int WIDTH = 800;
  const int HEIGHT = 450;

  raylib_c3::init_window(WIDTH, HEIGHT, "Raylib Example - 2D Camera");

  Rectangle player = Rectangle({ 400, 280, 40, 40 });
  Rectangle[MAX_BUILDINGS] buildings;
  Color[MAX_BUILDINGS] buildingColors;

  int spacing = 0;

  for (int i = 0; i < MAX_BUILDINGS; i++) {
    buildings[i].width = (float)(raylib_c3::get_random_value(50, 200));
    buildings[i].height = (float)(raylib_c3::get_random_value(100, 800));
    buildings[i].y = HEIGHT - 130.0 - buildings[i].height;
    buildings[i].x = (float)(-6000.0) + spacing;

    spacing += (int)(buildings[i].width);

    buildingColors[i] = Color({
      // These are really uint8s, not characters
      (char)(raylib_c3::get_random_value(200, 240)),
      (char)(raylib_c3::get_random_value(200, 240)),
      (char)(raylib_c3::get_random_value(200, 250)),
      255
    });
  }

  Camera2D camera;
  camera.target = Vector2({ player.x + 20.0, player.y + 20.0 });
  camera.offset = Vector2({ WIDTH/(float)(2.0), HEIGHT/(float)(2.0) });
  camera.rotation = 0.0;
  camera.zoom = 1.0;
  raylib_c3::set_target_fps(60);

  while (!raylib_c3::window_should_close()) { // main loop

    // Update
    // -----------------------------------------------------------------------
    if (raylib_c3::is_key_down(KeyboardKey.KEY_RIGHT)) {
      player.x += 2;
    } else if (raylib_c3::is_key_down(KeyboardKey.KEY_LEFT)) {
      player.x -= 2;
    }

    camera.target = Vector2({ player.x + 20, player.y + 20 });

    // camera rotation controls
    if (raylib_c3::is_key_down(KeyboardKey.KEY_A)) {
      camera.rotation--;
    } else if (raylib_c3::is_key_down(KeyboardKey.KEY_S)) {
      camera.rotation++;
    }

    // limit rotation to between -40 and 40 degrees
    if (camera.rotation > 40) {
      camera.rotation = 40;
    } else if (camera.rotation < -40) {
      camera.rotation = -40;
    }
    
    camera.zoom += (float)(raylib_c3::get_mouse_wheel_move())*0.05;

    if (camera.zoom > 3.0) {
      camera.zoom = 3.0;
    } else if (camera.zoom < 0.1) {
      camera.zoom = 0.1;
    }
    
    if (raylib_c3::is_key_pressed(KeyboardKey.KEY_R)) {
      camera.zoom = 1.0;
      camera.rotation = 0.0;
    }

    // Draw
    // -----------------------------------------------------------------------
    raylib_c3::begin_drawing();

      raylib_c3::clear_background(RAYWHITE);

      raylib_c3::begin_mode2_d(camera);

        raylib_c3::draw_rectangle(-6000, 320, 13000, 8000, DARKGRAY);

        for (int i = 0; i < MAX_BUILDINGS; i++)
          raylib_c3::draw_rectangle_rec(buildings[i], buildingColors[i]);

        raylib_c3::draw_rectangle_rec(player, RED);

        raylib_c3::draw_line(
          (int)(camera.target.x),
          -HEIGHT*10,
          (int)(camera.target.x), 
          HEIGHT*10,
          GREEN
        );
        raylib_c3::draw_line(
          -WIDTH*10,
          (int)(camera.target.y),
          WIDTH*10,
          (int)(camera.target.y),
          GREEN
        );

      raylib_c3::end_mode2_d();

      raylib_c3::draw_text("SCREEN AREA", 640, 10, 20, RED);

      raylib_c3::draw_rectangle(0, 0, WIDTH, 5, RED);
      raylib_c3::draw_rectangle(0, 5, 5, HEIGHT - 10, RED);
      raylib_c3::draw_rectangle(WIDTH - 5, 5, 5, HEIGHT - 10, RED);
      raylib_c3::draw_rectangle(0, HEIGHT - 5, WIDTH, 5, RED);

      raylib_c3::draw_rectangle( 10, 10, 250, 113, raylib_c3::fade(SKYBLUE, 0.5));
      raylib_c3::draw_rectangle_lines( 10, 10, 250, 113, BLUE);

      raylib_c3::draw_text("Free 2d camera controls:", 20, 20, 10, BLACK);
      raylib_c3::draw_text("- Right/Left to move Offset", 40, 40, 10, DARKGRAY);
      raylib_c3::draw_text("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY);
      raylib_c3::draw_text("- A / S to Rotate", 40, 80, 10, DARKGRAY);
      raylib_c3::draw_text("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY);

    raylib_c3::end_drawing();
  }

  // De-Initialization
  raylib_c3::close_window();
}
