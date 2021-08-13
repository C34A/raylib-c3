
module breakout;

import raylib_c3;

import std::io;

struct Box {
  Rectangle bounds;
  Color color;
  uint health;
}

const uint ROWS = 2;
const uint COLUMNS = 8;
const uint MAX_HEALTH = 1;

const float BLOCK_SPACING = 0.02;

const float BLOCK_WIDTH = (1.0 - ((COLUMNS + 1) * BLOCK_SPACING)) / COLUMNS;
const float BLOCK_HEIGHT = 0.05;

func int main() {
  Box[ROWS * COLUMNS] blocks;
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLUMNS; j++) {
      blocks[i + j] = Box({
        Rectangle({
          -1 + j * BLOCK_WIDTH + BLOCK_SPACING,
          1 - BLOCK_SPACING - i * BLOCK_HEIGHT,
          BLOCK_WIDTH,
          BLOCK_HEIGHT,
        }),
        rand_color(),
        MAX_HEALTH,
      });
      io::printf("adding box at (%f, %f) (%f, %f)\n",
        blocks[i + j].bounds.x,
        blocks[i + j].bounds.y,
        blocks[i + j].bounds.width,
        blocks[i + j].bounds.height
      );
    }
  }

  raylib_c3::set_config_flags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
  raylib_c3::init_window(800, 450, "Example - waving cubes");

  raylib_c3::set_target_fps(144);

  while (!raylib_c3::window_should_close()) {
    raylib_c3::begin_drawing();

      raylib_c3::clear_background(RAYWHITE);

      for (int i = 0; i < ROWS + COLUMNS; i++) {
        draw_box(blocks[i]);
      }
      // draw_box(Box({
      //   Rectangle({
      //     -0.5,
      //     0.5,
      //     0.5,
      //     0.5
      //   }),
      //   BLACK,
      //   1
      // }));

      // raylib_c3::draw_rectangle_rec(
      //   Rectangle({
      //     200,
      //     112,
      //     400,
      //     225
      //   }),
      //   BLACK
      // );

    raylib_c3::end_drawing();
  }

  return 0;
}

func Rectangle convert_coords(Rectangle rect) {
  float width = (float)(raylib_c3::get_screen_width());
  float height = (float)(raylib_c3::get_screen_height());
  return Rectangle({
    (float)(rect.x * width / 2.0) + width/2.0,
    (float)(-rect.y * height / 2.0) + height/2.0,
    rect.width * width/2,
    rect.height * height/2,
  });
}

func Color rand_color() {
  return raylib_c3::color_from_hsv(
    (float)( raylib_c3::get_random_value(0, 360) ),
    0.75,
    0.9,
  );
}

func void draw_box(Box box) {
  box.bounds = convert_coords(box.bounds);
  // io::printf("drawing box at (%f, %f) (%f, %f)\n", box.bounds.x, box.bounds.y, box.bounds.width, box.bounds.height);
  raylib_c3::draw_rectangle_rec(box.bounds, box.color);
}