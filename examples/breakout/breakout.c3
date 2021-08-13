
module breakout;

import raylib_c3;

struct Box {
  Rectangle bounds;
  Color color;
  uint health;
}

const uint ROWS = 2;
const uint COLUMNS = 8;
const uint MAX_HEALTH = 1;

const float BLOCK_SPACING = 0.02;

const BLOCK_WIDTH = (1.0 - ((COLUMNS + 1) * BLOCK_SPACING)) / COLUMNS;
const BLOCK_HEIGHT = 0.05;

func void main() {
  Box[ROWS * COLUMNS] blocks;
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLUMNS; j++) {
      blocks[i + j] = Box({
        Rectangle({
          -1 + j * BLOCK_WIDTH + BLOCK_WIDTH/2.0,
          1 - BLOCK_SPACING - BLOCK_HEIGHT/2.0 - i * BLOCK_HEIGHT,
          BLOCK_WIDTH,
          BLOCK_HEIGHT,
        }),
        rand_color(),
        MAX_HEALTH,
      });
    }
  }

  while (!raylib_c3::window_should_close()) {
    raylib_c3::begin_drawing();

      for (int i = 0; i < ROWS * COLUMNS; i++) {
        draw_box(blocks[i]);
      }

    raylib_c3::end_drawing();
  }
}

func Rectangle convert_coords(Rectangle rect) {
  int width = raylib_c3::get_screen_width();
  int height = raylib_c3::get_screen_height();
  return Rectangle({
    rect.x / width,
    -rect.y / height,
    rect.width / width,
    rect.height / height,
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
  raylib_c3::draw_rectangle_rec(box.bounds, box.color);
}