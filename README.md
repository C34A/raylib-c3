# Raylib-C3

This is my feeble attempt at making [C3](https://github.com/c3lang/c3c) language
bindings for [raylib](https://www.raylib.com/). It is loosely based on
[raylib-zig](https://github.com/Not-Nik/raylib-zig).

This project is a work in progress and is not currently stable. Use at your own risk.

## usage

```bash
python3 gen.py
python3 gen2.py
```

At this point, you should be able to use the generated `raylib.c3`.

To build examples, you can use `build-example.py`. This requires raylib to be installed at a system level- see [Raylib - Working on GNU Linux](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux).

```bash
python3 build-example.py basic_window
./a.out
```