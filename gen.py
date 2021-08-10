import re

"""
This is modified from the gen.py used by raylib-zig:
https://github.com/Not-Nik/raylib-zig

Automatic utility for generating raylib function headers. Simply put
raylib.h in the working directory of this script and execute.
"""


# Some c types have a different size on different systems
# c3 has equivalents in std::CInterop
def c_to_c3_type(t: str) -> str:
    t = t.replace("const ", "")
    if t == "float":
        t = "float"
    if t == "double":
        t = "double"
    if t == "int":
        t = "int"
    if t == "unsigned int":
        t = "uint"
    if t == "long":
        t = "long"
    if t == "char":
        t = "byte"
    if t == "unsigned char":
        t = "byte"
    return t

# magic regex from stackoverflow :P https://stackoverflow.com/questions/1175208/elegant-python-function-to-convert-camelcase-to-snake-case
re_pascal_to_snake_1 = re.compile("(.)([A-Z][a-z]+)")
re_pascal_to_snake_2 = re.compile("__([A-Z])")
re_pascal_to_snake_3 = re.compile("([a-z0-9])([A-Z])")
def to_snake_case(name):
    name = re_pascal_to_snake_1.sub(r'\1_\2', name)
    name = re_pascal_to_snake_2.sub(r'_\1', name)
    name = re_pascal_to_snake_3.sub(r'\1_\2', name)
    return name.lower()


def fix_enums(arg_name, arg_type, func_name):
    # Hacking specifc enums in here
    # Raylib doesn't use the enums but rather the resulting ints
    if arg_type == "int":
        if arg_name == "key":
            arg_type = "KeyboardKey"
        elif arg_name == "button":
            arg_type = "MouseButton"
        elif arg_name == "mode" and func_name == "SetCameraMode":
            arg_type = "CameraMode"
    return arg_type


small_structs = ["Vector2", "Vector3", "Vector4", "Quaternion", "Color", "Rectangle", "Shader"]


def parse_header(header_name: str, output_file: str, prefix: str):
    header = open(header_name, mode="r")
    c3_heads = []

    for line in header.readlines():
        if not line.startswith(prefix):
            continue

        line = line.split(";", 1)[0]
        # each (.*) is some variable value
        result = re.search(prefix + "(.*) (.*)start_arg(.*)end_arg(.*)", line.replace("(", "start_arg").replace(")", "end_arg"))

        # get whats in the (.*)'s
        return_type = result.group(1)
        func_name = result.group(2)
        arguments = result.group(3)

        return_type = c_to_c3_type(return_type)
        # func_name, return_type = fix_pointer(func_name, return_type)

        c3_arguments = []
        for arg in arguments.split(", "):
            if arg == "void":
                break
            if arg == "...":
                c3_arguments.append("...")
                continue
            arg_type = " ".join(arg.split(" ")[0:-1])  # everything but the last element (for stuff like "const Vector3")
            arg_type = arg_type.replace("const ", "")  # we'll add that later if needed
            arg_name = arg.split(" ")[-1]  # last element should be the name
            arg_type = fix_enums(arg_name, arg_type, func_name)

            arg_type = c_to_c3_type(arg_type)
            # arg_name, arg_type = fix_pointer(arg_name, arg_type)
            c3_arguments.append(arg_type + " " + arg_name)  # put everything together
        c3_arguments = ", ".join(c3_arguments)
        c3_heads.append("func " + return_type + " " + to_snake_case(func_name) + "(" + c3_arguments + ") @extname(\"" + func_name + "\");")

    c3header = open(output_file, mode="w")
    # print("module raylibc3;\n", file=c3header)

    print("\n".join(c3_heads), file=c3header)
    print("", file=c3header)


parse_header("raylib.h", "raylib-wa.c3", "RLAPI ")
parse_header("raymath.h", "raylib-c3-math.c3", "RMDEF ")
