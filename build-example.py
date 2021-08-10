
import sys
import os

if len(sys.argv) < 2:
  print("Usage: build-example.py [example_name]\nex: python3 build-example.py basic_window")
  exit()

# remove previous compilation to avoid confusion
os.remove('a.out')

exname = sys.argv[1]
print(f"building example {exname}")

c3c_command = f'c3c compile examples/raylib/{exname}.c3 raylib.c3'
cc_command = f'cc {exname}.o -s -fno-PIE -fno-pie -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 raylib_c3.o std.env.o std.cinterop.o std.runtime.o std.builtin.o std.io.o std.mem.o std.array.o std.math.o -o a.out'

os.system(c3c_command)
os.system(cc_command)

if os.path.exists('a.out'):
  print("Probably compiled successfully! Ignore c3c compilation errors, it probably still worked.")
  print("run ./a.out to execute.")
