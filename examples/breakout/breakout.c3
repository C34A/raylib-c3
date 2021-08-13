
module breakout;

import raylib_c3;

import std::io;

struct Box {
  Rectangle bounds; // x, y, width, height
  Color color;
  uint health; // don't draw or collide if this is 0. decrement on collision.
}

struct Ball {
  Vector2 pos; // position
  Vector2 vel; // velocity
}

const int WIDTH = 800;
const int HEIGHT = 450;

const float BALL_SIZE = 20.0;
const Color BALL_COLOR = BLUE;
const float BALL_SPEED = 2.5;

const uint ROWS = 2;
const uint COLUMNS = 8;
const uint MAX_HEALTH = 1;

const float BLOCK_SPACING = 10;

const float BLOCK_WIDTH = 88.75;
const float BLOCK_HEIGHT = 40;

const int PADDLE_SIZE = WIDTH / 6;
const int PADDLE_HEIGHT = 30;
const Color PADDLE_COLOR = PINK;

func int main() {
  // Block array
  Box[ROWS * COLUMNS] blocks;
  // Make a grid of blocks
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLUMNS; j++) {
      blocks[i * COLUMNS + j] = Box({
        Rectangle({
          j * BLOCK_WIDTH + BLOCK_SPACING * (j + 1),
          (i + 1) * BLOCK_SPACING + i * BLOCK_HEIGHT,
          BLOCK_WIDTH,
          BLOCK_HEIGHT,
        }),
        rand_color(),
        MAX_HEALTH,
      });
    }
  }

  Ball ball = Ball({
    Vector2({WIDTH / 2, HEIGHT / 2}),
    Vector2({0.0, 1.0})
  });

  Rectangle paddle = Rectangle({
    (WIDTH - PADDLE_SIZE) / 2,
    400,
    PADDLE_SIZE,
    PADDLE_HEIGHT,
  });

  uint score = 0;
  uint lives = 3;
  bool gameOver = false;



  raylib_c3::init_window(WIDTH, HEIGHT, "Breakout!");
  raylib_c3::init_audio_device();
  raylib_c3::set_target_fps(144);

  // These must be after init_audio_device!
  Sound beep = raylib_c3::load_sound("examples/breakout/res/beep.wav");
  Sound beep2 = raylib_c3::load_sound("examples/breakout/res/beep2.wav");
  Sound boop = raylib_c3::load_sound("examples/breakout/res/boop.wav");

  while (!raylib_c3::window_should_close()) {
    // Update
    if (!gameOver) {
      ball.pos.x += ball.vel.x * BALL_SPEED; // todo: Vector2/3/4 operator overloading
      ball.pos.y += ball.vel.y * BALL_SPEED;

      // paddle movement
      if (raylib_c3::is_key_down(raylib_c3::KeyboardKey.KEY_RIGHT) && paddle.x < (WIDTH - PADDLE_SIZE)) {
        paddle.x += 2.0;
      }
      if (raylib_c3::is_key_down(raylib_c3::KeyboardKey.KEY_LEFT) && paddle.x > 0) {
        paddle.x -= 2.0;
      }

      // collisions
      do {
        // Only allow one collision per frame for simplicity

        // walls
        uint wall = collide_ball_walls(&ball, WIDTH, HEIGHT);
        if (wall) {
          if (wall == 3) {
            lives--;
            if (lives == 0) gameOver = true;
            raylib_c3::play_sound(boop);
          }
          raylib_c3::play_sound(beep2);
          break;
        }
        // paddle
        if (collide_ball_paddle(&ball, &paddle)) {
          raylib_c3::play_sound(beep2);
          break;
        }
        // blocks
        for (int i = 0; i < (ROWS * COLUMNS); i++) {
          if (collide_ball_block(&ball, &blocks[i])) {
            score++;
            raylib_c3::play_sound(beep);
            break;
          }
        }
      } while (false);
    } // if (!gameOver)

    raylib_c3::begin_drawing();

      raylib_c3::clear_background(RAYWHITE);

      // Draw blocks
      for (int i = 0; i < (ROWS * COLUMNS); i++) {
        if(blocks[i].health > 0) draw_box(blocks[i]);
      }

      // Draw ball
      raylib_c3::draw_circle_v(ball.pos, BALL_SIZE, BALL_COLOR);

      // Draw paddle
      raylib_c3::draw_rectangle_rec(paddle, PADDLE_COLOR);

      // Draw score, lives
      raylib_c3::draw_text(
        raylib_c3::text_format("Score: %d", score),
        10,
        300,
        20,
        RED,
      );
      raylib_c3::draw_text(
        raylib_c3::text_format("Lives: %d", lives),
        10,
        320,
        20,
        RED,
      );

      if (gameOver) {
        raylib_c3::draw_text(
          "Game Over!",
          320,
          220,
          30,
          RED,
        );
      }

    raylib_c3::end_drawing();
  }
  raylib_c3::close_audio_device();
  return 0;
}

func Color rand_color() {
  return raylib_c3::color_from_hsv(
    (float)( raylib_c3::get_random_value(0, 360) ),
    0.75,
    0.9,
  );
}

func void draw_box(Box box) {
  // io::printf("drawing box at (%f, %f) (%f, %f)\n", box.bounds.x, box.bounds.y, box.bounds.width, box.bounds.height);
  raylib_c3::draw_rectangle_rec(box.bounds, box.color);
}

/**
 * Checks collision between ball and block and updates ball velocity and health
 */
func bool collide_ball_block(Ball* ball, Box* block) {
  if (block.health > 0 && collide_ball_rect(ball, &(block.bounds))) {
    block.health--;
    return true;
  }
  return false;
}

/**
 * Checks collision between ball and rectangle and updates ball velocity
 */
func bool collide_ball_rect(Ball* ball, Rectangle* rect) {
  if (!raylib_c3::check_collision_circle_rec(ball.pos, BALL_SIZE, *rect)) return false;
  // did collide -> update velocity
  if (ball.pos.y <= rect.y || ball.pos.y >= (rect.y + rect.height)) {
    // collision was top/bottom
    ball.vel.y *= -1;
  } else {
    // collision was one of the sides
    ball.vel.x *= -1;
  }
  return true;
}

/**
 * Checks collision between ball sides, updates velocity, returns which wall was hit
 * none = 0, top = 1, right = 2, bottom = 3, left = 4
 */
func int collide_ball_walls(Ball* ball, int width, int height) {
  if ((ball.pos.y + BALL_SIZE) >= height) {
    // collision with bottom
    ball.vel.y *= -1;
    return 3;
  }
  if ((ball.pos.y - BALL_SIZE) <= 0) {
    // collision with top
    ball.vel.y *= -1;
    return 1;
  }
  if ((ball.pos.x + BALL_SIZE) >= width) {
    // collision with right side
    ball.vel.x *= -1;
    return 2;
  }
  if ((ball.pos.x - BALL_SIZE) <= 0) {
    // collision with left side
    ball.vel.x *= -1;
    return 4;
  }
  return 0;
}

func bool collide_ball_paddle(Ball* ball, Rectangle* paddle) {
  if (raylib_c3::check_collision_circle_rec(ball.pos, BALL_SIZE, *paddle)) {
    ball.vel = raylib_c3::vector2_normalize(Vector2({
      (ball.pos.x - (paddle.x + PADDLE_SIZE/2)) / (PADDLE_SIZE/2), // range from -1 to 1
      -1.0
    }));
    return true;
  }
  return false;
}