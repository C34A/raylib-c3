module test;

import raylib_c3;

import std::io;

func int main() {
  raylib-c3::InitWindow(800, 400, "example");

  raylib-c3::SetTargetFPS(144);
  while(!raylib-c3::WindowShouldClose()) {
    raylib-c3::BeginDrawing();
      raylib-c3::ClearBackground(RAYWHITE);
      raylib-c3::DrawText("Success!", 190, 200, 20, DARKGRAY);
    raylib-c3::EndDrawing();
  }
}