"""
This script simply takes the contents of raylib-gen.c3 and raylib-math.c3
and puts them into raylib_types.c3 to create raylib.c3
"""

f_math = open("raylib-math.c3")
math = f_math.read()
f_math.close()

f_gen = open("raylib-gen.c3")
gen = f_gen.read()
f_gen.close()

f_types = open("raylib-gen.c3")
types = f_gen.read()
f_types.close()

types.replace(r'%replaceme_math%', math)
types.replace(r'%replaceme_general%', gen)

with open("raylib.c3") as out:
  out.write(types)