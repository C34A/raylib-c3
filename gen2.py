"""
This script simply takes the contents of raylib-gen.c3 and raylib-math.c3
and puts them into raylib_types.c3 to create raylib.c3
"""

f_math = open("raylib-math.c3", "r")
math = f_math.read()
f_math.close()

f_gen = open("raylib-gen.c3", "r")
gen = f_gen.read()
f_gen.close()

f_types = open("raylib_types.c3", "r")
types = f_types.read()
f_types.close()

math = math.replace('float3', 'Float3')
math = math.replace('float16', 'Float16')

types = types.replace('!replaceme_math!', math)
types = types.replace('!replaceme_general!', gen)

with open("raylib.c3", "w") as out:
  out.write(types)