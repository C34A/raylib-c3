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
final = f_types.read()
f_types.close()

# types must start with an uppercase character
math = math.replace('float3', 'Float3')
math = math.replace('float16', 'Float16')

# These callbacks require passing function pointers, which I don't want to deal with yet
gen = gen.replace('extern func void set_trace_log_callback(TraceLogCallback callback) @extname("SetTraceLogCallback");\nextern func void set_load_file_data_callback(LoadFileDataCallback callback) @extname("SetLoadFileDataCallback");\nextern func void set_save_file_data_callback(SaveFileDataCallback callback) @extname("SetSaveFileDataCallback");\nextern func void set_load_file_text_callback(LoadFileTextCallback callback) @extname("SetLoadFileTextCallback");\nextern func void set_save_file_text_callback(SaveFileTextCallback callback) @extname("SetSaveFileTextCallback");'
, '// not dealing with these yet\n// extern func void set_trace_log_callback(TraceLogCallback callback) @extname("SetTraceLogCallback");\n// extern func void set_load_file_data_callback(LoadFileDataCallback callback) @extname("SetLoadFileDataCallback");\n// extern func void set_save_file_data_callback(SaveFileDataCallback callback) @extname("SetSaveFileDataCallback");\n// extern func void set_load_file_text_callback(LoadFileTextCallback callback) @extname("SetLoadFileTextCallback");\n// extern func void set_save_file_text_callback(SaveFileTextCallback callback) @extname("SetSaveFileTextCallback");')

# quad in c3 is a f128
gen = gen.replace('Rectangle quad', 'Rectangle quad_')

final = final.replace('!replaceme_math!', math)
final = final.replace('!replaceme_general!', gen)

# fix this garbage
final = final.replace('_mode3_d', '_mode_3d')
final = final.replace('_mode2_d', '_mode_2d')

with open("raylib.c3", "w") as out:
  out.write(final)