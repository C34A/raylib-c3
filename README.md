# Raylib-C3

Raylib-c3 provides minimal raylib bindings for the [C3](https://github.com/c3lang/c3c) language. It is loosely based on
[raylib-zig](https://github.com/Not-Nik/raylib-zig).

This project is a work in progress and is not currently stable. Use at your own risk.

Raylib-c3 currently only supports linux and dynamic linking to raylib, though static linking is theoretically possible. It does not yet work on windows, due to extremely limited windows support from C3C.

## usage

If you would like to generate a new version of raylib.c3 from a raylib.h header, run these scripts:

```bash
python3 gen.py
python3 gen2.py
```

At this point, you should be able to use the generated `raylib.c3`.

To build examples, you can use `build-example.py`. This requires raylib to be installed at a system
level- see [Raylib - Working on GNU Linux](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux).

```bash
python3 build-example.py raylib/basic_window
./a.out
```
