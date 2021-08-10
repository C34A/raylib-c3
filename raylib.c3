// raylib-c3
// Author: C34A
// Date: 2021-08-09

module raylib_c3;

struct Vector2 {
  float x;
  float y;
}

struct Vector3 {
  float x;
  float y;
  float z;
}

struct Float3 {
  float[3] v;
}

struct Float16 {
  float[16] v;
}

struct Vector4 {
  float x;
  float y;
  float z;
  float w;
}

define Quaternion = Vector3;

struct Matrix {
  float m0;
  float m4;
  float m8;
  float m12;
  float m1;
  float m5;
  float m9;
  float m13;
  float m2;
  float m6;
  float m10;
  float m14;
  float m3;
  float m7;
  float m11;
  float m15;
}

struct Color {
  char r;
  char g;
  char b;
  char a;
}

const LIGHTGRAY =  Color({ 200, 200, 200, 255 });   // Light Gray
const GRAY =       Color({ 130, 130, 130, 255 });   // Gray
const DARKGRAY =   Color({ 80, 80, 80, 255 });      // Dark Gray
const YELLOW =     Color({ 253, 249, 0, 255 });     // Yellow
const GOLD =       Color({ 255, 203, 0, 255 });     // Gold
const ORANGE =     Color({ 255, 161, 0, 255 });     // Orange
const PINK =       Color({ 255, 109, 194, 255 });   // Pink
const RED =        Color({ 230, 41, 55, 255 });     // Red
const MAROON =     Color({ 190, 33, 55, 255 });     // Maroon
const GREEN =      Color({ 0, 228, 48, 255 });      // Green
const LIME =       Color({ 0, 158, 47, 255 });      // Lime
const DARKGREEN =  Color({ 0, 117, 44, 255 });      // Dark Green
const SKYBLUE =    Color({ 102, 191, 255, 255 });   // Sky Blue
const BLUE =       Color({ 0, 121, 241, 255 });     // Blue
const DARKBLUE =   Color({ 0, 82, 172, 255 });      // Dark Blue
const PURPLE =     Color({ 200, 122, 255, 255 });   // Purple
const VIOLET =     Color({ 135, 60, 190, 255 });    // Violet
const DARKPURPLE = Color({ 112, 31, 126, 255 });    // Dark Purple
const BEIGE =      Color({ 211, 176, 131, 255 });   // Beige
const BROWN =      Color({ 127, 106, 79, 255 });    // Brown
const DARKBROWN =  Color({ 76, 63, 47, 255 });      // Dark Brown

const WHITE =      Color({ 255, 255, 255, 255 });   // White
const BLACK =      Color({ 0, 0, 0, 255 });         // Black
const BLANK =      Color({ 0, 0, 0, 0 });           // Blank (Transparent)
const MAGENTA =    Color({ 255, 0, 255, 255 });     // Magenta
const RAYWHITE =   Color({ 245, 245, 245, 255 });   // Ray's own White (raylib logo)

struct Rectangle {
  float x;
  float y;
  float width;
  float height;
}

struct Image {
  void *data;             // Image raw data
  int width;              // Image base width
  int height;             // Image base height
  int mipmaps;            // Mipmap levels, 1 by default
  int format;             // Data format (PixelFormat type)
}

struct Texture {
  uint id;                // OpenGL texture id
  int width;              // Texture base width
  int height;             // Texture base height
  int mipmaps;            // Mipmap levels, 1 by default
  int format;             // Data format (PixelFormat type)
}

define Texture2D = Texture;
define TextureCubemap = Texture;

// RenderTexture, fbo for texture rendering
struct RenderTexture {
  uint id;        // OpenGL framebuffer object id
  Texture texture;        // Color buffer attachment texture
  Texture depth;          // Depth buffer attachment texture
}

define RenderTexture2D = RenderTexture;

// NPatchInfo, n-patch layout info
struct NPatchInfo {
  Rectangle source;       // Texture source rectangle
  int left;               // Left border offset
  int top;                // Top border offset
  int right;              // Right border offset
  int bottom;             // Bottom border offset
  int layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1
}

// CharInfo, font character info
struct CharInfo {
  int value;              // Character value (Unicode)
  int offsetX;            // Character offset X when drawing
  int offsetY;            // Character offset Y when drawing
  int advanceX;           // Character advance position X
  Image image;            // Character image data
}

// Font, font texture and CharInfo array data
struct Font {
  int baseSize;           // Base size (default chars height)
  int charsCount;         // Number of characters
  int charsPadding;       // Padding around the chars
  Texture2D texture;      // Characters texture atlas
  Rectangle *recs;        // Characters rectangles in texture
  CharInfo *chars;        // Characters info data
}

// Camera, defines position/orientation in 3d space
struct Camera3D {
  Vector3 position;       // Camera position
  Vector3 target;         // Camera target it looks-at
  Vector3 up;             // Camera up vector (rotation over its axis)
  float fovy;             // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
  int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

define Camera = Camera3D;

// Camera2D, defines position/orientation in 2d space
struct Camera2D {
  Vector2 offset;         // Camera offset (displacement from target)
  Vector2 target;         // Camera target (rotation and zoom origin)
  float rotation;         // Camera rotation in degrees
  float zoom;             // Camera zoom (scaling), should be 1.0f by default
}

// Mesh, vertex data and vao/vbo
struct Mesh {
  int vertexCount;        // Number of vertices stored in arrays
  int triangleCount;      // Number of triangles stored (indexed or not)

  // Default vertex data
  float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
  float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
  float *texcoords2;      // Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
  float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
  float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
  char *colors;           // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
  ushort *indices;        // Vertex indices (in case vertex data comes indexed)

  // Animation vertex data
  float *animVertices;    // Animated vertex positions (after bones transformations)
  float *animNormals;     // Animated normals (after bones transformations)
  int *boneIds;           // Vertex bone ids, up to 4 bones influence by vertex (skinning)
  float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning)

  // OpenGL identifiers
  uint vaoId;             // OpenGL Vertex Array Object id
  uint *vboId;            // OpenGL Vertex Buffer Objects id (default vertex data)
}

// Shader
struct Shader {
  uint id;        // Shader program id
  int *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)
}

// MaterialMap
struct MaterialMap {
  Texture2D texture;      // Material map texture
  Color color;            // Material map color
  float value;            // Material map value
}

// Material, includes shader and maps
struct Material {
  Shader shader;          // Material shader
  MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)
  float[4] params;        // Material generic parameters (if required)
}

// Transform, vectex transformation data
struct Transform {
  Vector3 translation;    // Translation
  Quaternion rotation;    // Rotation
  Vector3 scale;          // Scale
}

// Bone, skeletal animation bone
struct BoneInfo {
  char[32] name;          // Bone name
  int parent;             // Bone parent
}

// Model, meshes, materials and animation data
struct Model {
  Matrix transform;       // Local transform matrix

  int meshCount;          // Number of meshes
  int materialCount;      // Number of materials
  Mesh *meshes;           // Meshes array
  Material *materials;    // Materials array
  int *meshMaterial;      // Mesh material number

  // Animation data
  int boneCount;          // Number of bones
  BoneInfo *bones;        // Bones information (skeleton)
  Transform *bindPose;    // Bones base transformation (pose)
}

// ModelAnimation
struct ModelAnimation {
  int boneCount;          // Number of bones
  int frameCount;         // Number of animation frames
  BoneInfo *bones;        // Bones information (skeleton)
  Transform **framePoses; // Poses array by frame
}

// Ray, ray for raycasting
struct Ray {
  Vector3 position;       // Ray position (origin)
  Vector3 direction;      // Ray direction
}

// RayCollision, ray hit information
struct RayCollision {
  bool hit;               // Did the ray hit something?
  float distance;         // Distance to nearest hit
  Vector3 point;          // Point of nearest hit
  Vector3 normal;         // Surface normal of hit
}

// BoundingBox
struct BoundingBox {
  Vector3 min;            // Minimum vertex box-corner
  Vector3 max;            // Maximum vertex box-corner
}

// Wave, audio wave data
struct Wave {
  uint sampleCount;   // Total number of samples (considering channels!)
  uint sampleRate;    // Frequency (samples per second)
  uint sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  uint channels;      // Number of channels (1-mono, 2-stereo)
  void *data;                 // Buffer data pointer
}

// c: typedef struct rAudioBuffer rAudioBuffer;
// This appears to be only used as a pointer, so i think its ok to just do this?
// maybe AudioStream should use a void*? idk.
// struct RAudioBuffer;

// AudioStream, custom audio stream
struct AudioStream {
  void *buffer;       // Pointer to internal data used by the audio system

  uint sampleRate;            // Frequency (samples per second)
  uint sampleSize;            // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  uint channels;              // Number of channels (1-mono, 2-stereo)
}

// Sound
struct Sound {
  AudioStream stream;         // Audio stream
  uint sampleCount;   // Total number of samples
}

// Music, audio stream, anything longer than ~10 seconds should be streamed
struct Music {
  AudioStream stream;         // Audio stream
  uint sampleCount;   // Total number of samples
  bool looping;               // Music looping enable

  int ctxType;                // Type of music context (audio filetype)
  void *ctxData;              // Audio context data, depends on type
}

// VrDeviceInfo, Head-Mounted-Display device parameters
struct VrDeviceInfo {
  int hResolution;                // Horizontal resolution in pixels
  int vResolution;                // Vertical resolution in pixels
  float hScreenSize;              // Horizontal size in meters
  float vScreenSize;              // Vertical size in meters
  float vScreenCenter;            // Screen center in meters
  float eyeToScreenDistance;      // Distance between eye and display in meters
  float lensSeparationDistance;   // Lens separation distance in meters
  float interpupillaryDistance;   // IPD (distance between pupils) in meters
  float[4] lensDistortionValues;  // Lens distortion constant parameters
  float[4] chromaAbCorrection;    // Chromatic aberration correction parameters
}

// VrStereoConfig, VR stereo rendering configuration for simulator
struct VrStereoConfig {
  Matrix[2] projection;           // VR projection matrices (per eye)
  Matrix[2] viewOffset;           // VR view offset matrices (per eye)
  float[2] leftLensCenter;        // VR left lens center
  float[2] rightLensCenter;       // VR right lens center
  float[2] leftScreenCenter;      // VR left screen center
  float[2] rightScreenCenter;     // VR right screen center
  float[2] scale;                 // VR distortion scale
  float[2] scaleIn;               // VR distortion scale in
}

// System/Window config flags
// NOTE: Every bit registers one state (use it with bit masks)
// By default all flags are set to 0
enum ConfigFlags: uint {
  FLAG_VSYNC_HINT         = 0x00000040,   // Set to try enabling V-Sync on GPU
  FLAG_FULLSCREEN_MODE    = 0x00000002,   // Set to run program in fullscreen
  FLAG_WINDOW_RESIZABLE   = 0x00000004,   // Set to allow resizable window
  FLAG_WINDOW_UNDECORATED = 0x00000008,   // Set to disable window decoration (frame and buttons)
  FLAG_WINDOW_HIDDEN      = 0x00000080,   // Set to hide window
  FLAG_WINDOW_MINIMIZED   = 0x00000200,   // Set to minimize window (iconify)
  FLAG_WINDOW_MAXIMIZED   = 0x00000400,   // Set to maximize window (expanded to monitor)
  FLAG_WINDOW_UNFOCUSED   = 0x00000800,   // Set to window non focused
  FLAG_WINDOW_TOPMOST     = 0x00001000,   // Set to window always on top
  FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   // Set to allow windows running while minimized
  FLAG_WINDOW_TRANSPARENT = 0x00000010,   // Set to allow transparent framebuffer
  FLAG_WINDOW_HIGHDPI     = 0x00002000,   // Set to support HighDPI
  FLAG_MSAA_4X_HINT       = 0x00000020,   // Set to try enabling MSAA 4X
  FLAG_INTERLACED_HINT    = 0x00010000    // Set to try enabling interlaced video format (for V3D)
}

// Trace log level
// NOTE: Organized by priority level
enum TraceLogLevel : int {
  LOG_ALL = 0,        // Display all logs
  LOG_TRACE,          // Trace logging, intended for internal use only
  LOG_DEBUG,          // Debug logging, used for internal debugging, it should be disabled on release builds
  LOG_INFO,           // Info logging, used for program execution info
  LOG_WARNING,        // Warning logging, used on recoverable failures
  LOG_ERROR,          // Error logging, used on unrecoverable failures
  LOG_FATAL,          // Fatal logging, used to abort program: exit(EXIT_FAILURE)
  LOG_NONE            // Disable logging
}

// Keyboard keys (US keyboard layout)
// NOTE: Use GetKeyPressed() to allow redefining
// required keys for alternative layouts
enum KeyboardKey : int {
  KEY_NULL            = 0,        // Key: NULL, used for no key pressed
  // Alphanumeric keys
  KEY_APOSTROPHE      = 39,       // Key: '
  KEY_COMMA           = 44,       // Key: ,
  KEY_MINUS           = 45,       // Key: -
  KEY_PERIOD          = 46,       // Key: .
  KEY_SLASH           = 47,       // Key: /
  KEY_ZERO            = 48,       // Key: 0
  KEY_ONE             = 49,       // Key: 1
  KEY_TWO             = 50,       // Key: 2
  KEY_THREE           = 51,       // Key: 3
  KEY_FOUR            = 52,       // Key: 4
  KEY_FIVE            = 53,       // Key: 5
  KEY_SIX             = 54,       // Key: 6
  KEY_SEVEN           = 55,       // Key: 7
  KEY_EIGHT           = 56,       // Key: 8
  KEY_NINE            = 57,       // Key: 9
  KEY_SEMICOLON       = 59,       // Key: ;
  KEY_EQUAL           = 61,       // Key: =
  KEY_A               = 65,       // Key: A | a
  KEY_B               = 66,       // Key: B | b
  KEY_C               = 67,       // Key: C | c
  KEY_D               = 68,       // Key: D | d
  KEY_E               = 69,       // Key: E | e
  KEY_F               = 70,       // Key: F | f
  KEY_G               = 71,       // Key: G | g
  KEY_H               = 72,       // Key: H | h
  KEY_I               = 73,       // Key: I | i
  KEY_J               = 74,       // Key: J | j
  KEY_K               = 75,       // Key: K | k
  KEY_L               = 76,       // Key: L | l
  KEY_M               = 77,       // Key: M | m
  KEY_N               = 78,       // Key: N | n
  KEY_O               = 79,       // Key: O | o
  KEY_P               = 80,       // Key: P | p
  KEY_Q               = 81,       // Key: Q | q
  KEY_R               = 82,       // Key: R | r
  KEY_S               = 83,       // Key: S | s
  KEY_T               = 84,       // Key: T | t
  KEY_U               = 85,       // Key: U | u
  KEY_V               = 86,       // Key: V | v
  KEY_W               = 87,       // Key: W | w
  KEY_X               = 88,       // Key: X | x
  KEY_Y               = 89,       // Key: Y | y
  KEY_Z               = 90,       // Key: Z | z
  KEY_LEFT_BRACKET    = 91,       // Key: [
  KEY_BACKSLASH       = 92,       // Key: '\'
  KEY_RIGHT_BRACKET   = 93,       // Key: ]
  KEY_GRAVE           = 96,       // Key: `
  // extern function keys
  KEY_SPACE           = 32,       // Key: Space
  KEY_ESCAPE          = 256,      // Key: Esc
  KEY_ENTER           = 257,      // Key: Enter
  KEY_TAB             = 258,      // Key: Tab
  KEY_BACKSPACE       = 259,      // Key: Backspace
  KEY_INSERT          = 260,      // Key: Ins
  KEY_DELETE          = 261,      // Key: Del
  KEY_RIGHT           = 262,      // Key: Cursor right
  KEY_LEFT            = 263,      // Key: Cursor left
  KEY_DOWN            = 264,      // Key: Cursor down
  KEY_UP              = 265,      // Key: Cursor up
  KEY_PAGE_UP         = 266,      // Key: Page up
  KEY_PAGE_DOWN       = 267,      // Key: Page down
  KEY_HOME            = 268,      // Key: Home
  KEY_END             = 269,      // Key: End
  KEY_CAPS_LOCK       = 280,      // Key: Caps lock
  KEY_SCROLL_LOCK     = 281,      // Key: Scroll down
  KEY_NUM_LOCK        = 282,      // Key: Num lock
  KEY_PRINT_SCREEN    = 283,      // Key: Print screen
  KEY_PAUSE           = 284,      // Key: Pause
  KEY_F1              = 290,      // Key: F1
  KEY_F2              = 291,      // Key: F2
  KEY_F3              = 292,      // Key: F3
  KEY_F4              = 293,      // Key: F4
  KEY_F5              = 294,      // Key: F5
  KEY_F6              = 295,      // Key: F6
  KEY_F7              = 296,      // Key: F7
  KEY_F8              = 297,      // Key: F8
  KEY_F9              = 298,      // Key: F9
  KEY_F10             = 299,      // Key: F10
  KEY_F11             = 300,      // Key: F11
  KEY_F12             = 301,      // Key: F12
  KEY_LEFT_SHIFT      = 340,      // Key: Shift left
  KEY_LEFT_CONTROL    = 341,      // Key: Control left
  KEY_LEFT_ALT        = 342,      // Key: Alt left
  KEY_LEFT_SUPER      = 343,      // Key: Super left
  KEY_RIGHT_SHIFT     = 344,      // Key: Shift right
  KEY_RIGHT_CONTROL   = 345,      // Key: Control right
  KEY_RIGHT_ALT       = 346,      // Key: Alt right
  KEY_RIGHT_SUPER     = 347,      // Key: Super right
  KEY_KB_MENU         = 348,      // Key: KB menu
  // Keypad keys
  KEY_KP_0            = 320,      // Key: Keypad 0
  KEY_KP_1            = 321,      // Key: Keypad 1
  KEY_KP_2            = 322,      // Key: Keypad 2
  KEY_KP_3            = 323,      // Key: Keypad 3
  KEY_KP_4            = 324,      // Key: Keypad 4
  KEY_KP_5            = 325,      // Key: Keypad 5
  KEY_KP_6            = 326,      // Key: Keypad 6
  KEY_KP_7            = 327,      // Key: Keypad 7
  KEY_KP_8            = 328,      // Key: Keypad 8
  KEY_KP_9            = 329,      // Key: Keypad 9
  KEY_KP_DECIMAL      = 330,      // Key: Keypad .
  KEY_KP_DIVIDE       = 331,      // Key: Keypad /
  KEY_KP_MULTIPLY     = 332,      // Key: Keypad *
  KEY_KP_SUBTRACT     = 333,      // Key: Keypad -
  KEY_KP_ADD          = 334,      // Key: Keypad +
  KEY_KP_ENTER        = 335,      // Key: Keypad Enter
  KEY_KP_EQUAL        = 336,      // Key: Keypad =
  // Android key buttons
  KEY_BACK            = 4,        // Key: Android back button
  KEY_MENU            = 82,       // Key: Android menu button
  KEY_VOLUME_UP       = 24,       // Key: Android volume up button
  KEY_VOLUME_DOWN     = 25        // Key: Android volume down button
}

// Mouse buttons
enum MouseButton : int {
  MOUSE_BUTTON_LEFT    = 0,       // Mouse button left
  MOUSE_BUTTON_RIGHT   = 1,       // Mouse button right
  MOUSE_BUTTON_MIDDLE  = 2,       // Mouse button middle (pressed wheel)
  MOUSE_BUTTON_SIDE    = 3,       // Mouse button side (advanced mouse device)
  MOUSE_BUTTON_EXTRA   = 4,       // Mouse button extra (advanced mouse device)
  MOUSE_BUTTON_FORWARD = 5,       // Mouse button fordward (advanced mouse device)
  MOUSE_BUTTON_BACK    = 6,       // Mouse button back (advanced mouse device)
}

// Mouse cursor
enum MouseCursor : int {
  MOUSE_CURSOR_DEFAULT       = 0,     // Default pointer shape
  MOUSE_CURSOR_ARROW         = 1,     // Arrow shape
  MOUSE_CURSOR_IBEAM         = 2,     // Text writing cursor shape
  MOUSE_CURSOR_CROSSHAIR     = 3,     // Cross shape
  MOUSE_CURSOR_POINTING_HAND = 4,     // Pointing hand cursor
  MOUSE_CURSOR_RESIZE_EW     = 5,     // Horizontal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NS     = 6,     // Vertical resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NWSE   = 7,     // Top-left to bottom-right diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NESW   = 8,     // The top-right to bottom-left diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_ALL    = 9,     // The omni-directional resize/move cursor shape
  MOUSE_CURSOR_NOT_ALLOWED   = 10     // The operation-not-allowed shape
}

// Gamepad buttons
enum GamepadButton : int {
  GAMEPAD_BUTTON_UNKNOWN = 0,         // Unknown button, just for error checking
  GAMEPAD_BUTTON_LEFT_FACE_UP,        // Gamepad left DPAD up button
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT,     // Gamepad left DPAD right button
  GAMEPAD_BUTTON_LEFT_FACE_DOWN,      // Gamepad left DPAD down button
  GAMEPAD_BUTTON_LEFT_FACE_LEFT,      // Gamepad left DPAD left button
  GAMEPAD_BUTTON_RIGHT_FACE_UP,       // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,    // Gamepad right button right (i.e. PS3: Square, Xbox: X)
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN,     // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT,     // Gamepad right button left (i.e. PS3: Circle, Xbox: B)
  GAMEPAD_BUTTON_LEFT_TRIGGER_1,      // Gamepad top/back trigger left (first), it could be a trailing button
  GAMEPAD_BUTTON_LEFT_TRIGGER_2,      // Gamepad top/back trigger left (second), it could be a trailing button
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1,     // Gamepad top/back trigger right (one), it could be a trailing button
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2,     // Gamepad top/back trigger right (second), it could be a trailing button
  GAMEPAD_BUTTON_MIDDLE_LEFT,         // Gamepad center buttons, left one (i.e. PS3: Select)
  GAMEPAD_BUTTON_MIDDLE,              // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
  GAMEPAD_BUTTON_MIDDLE_RIGHT,        // Gamepad center buttons, right one (i.e. PS3: Start)
  GAMEPAD_BUTTON_LEFT_THUMB,          // Gamepad joystick pressed button left
  GAMEPAD_BUTTON_RIGHT_THUMB          // Gamepad joystick pressed button right
}

// Gamepad axis
enum GamepadAxis : int {
  GAMEPAD_AXIS_LEFT_X        = 0,     // Gamepad left stick X axis
  GAMEPAD_AXIS_LEFT_Y        = 1,     // Gamepad left stick Y axis
  GAMEPAD_AXIS_RIGHT_X       = 2,     // Gamepad right stick X axis
  GAMEPAD_AXIS_RIGHT_Y       = 3,     // Gamepad right stick Y axis
  GAMEPAD_AXIS_LEFT_TRIGGER  = 4,     // Gamepad back trigger left, pressure level: [1..-1]
  GAMEPAD_AXIS_RIGHT_TRIGGER = 5      // Gamepad back trigger right, pressure level: [1..-1]
}

// Material map index
// These might be broken since they don't specify values... idk
// Also, not sure if this is int. I assume it is.
enum MaterialMapIndex : int {
  MATERIAL_MAP_ALBEDO    = 0,     // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
  MATERIAL_MAP_METALNESS,         // Metalness material (same as: MATERIAL_MAP_SPECULAR)
  MATERIAL_MAP_NORMAL,            // Normal material
  MATERIAL_MAP_ROUGHNESS,         // Roughness material
  MATERIAL_MAP_OCCLUSION,         // Ambient occlusion material
  MATERIAL_MAP_EMISSION,          // Emission material
  MATERIAL_MAP_HEIGHT,            // Heightmap material
  MATERIAL_MAP_CUBEMAP,           // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_IRRADIANCE,        // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_PREFILTER,         // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_BRDG               // Brdg material
}

// Shader location index
enum ShaderLocationIndex : int{
  SHADER_LOC_VERTEX_POSITION = 0, // Shader location: vertex attribute: position
  SHADER_LOC_VERTEX_TEXCOORD01,   // Shader location: vertex attribute: texcoord01
  SHADER_LOC_VERTEX_TEXCOORD02,   // Shader location: vertex attribute: texcoord02
  SHADER_LOC_VERTEX_NORMAL,       // Shader location: vertex attribute: normal
  SHADER_LOC_VERTEX_TANGENT,      // Shader location: vertex attribute: tangent
  SHADER_LOC_VERTEX_COLOR,        // Shader location: vertex attribute: color
  SHADER_LOC_MATRIX_MVP,          // Shader location: matrix uniform: model-view-projection
  SHADER_LOC_MATRIX_VIEW,         // Shader location: matrix uniform: view (camera transform)
  SHADER_LOC_MATRIX_PROJECTION,   // Shader location: matrix uniform: projection
  SHADER_LOC_MATRIX_MODEL,        // Shader location: matrix uniform: model (transform)
  SHADER_LOC_MATRIX_NORMAL,       // Shader location: matrix uniform: normal
  SHADER_LOC_VECTOR_VIEW,         // Shader location: vector uniform: view
  SHADER_LOC_COLOR_DIFFUSE,       // Shader location: vector uniform: diffuse color
  SHADER_LOC_COLOR_SPECULAR,      // Shader location: vector uniform: specular color
  SHADER_LOC_COLOR_AMBIENT,       // Shader location: vector uniform: ambient color
  SHADER_LOC_MAP_ALBEDO,          // Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
  SHADER_LOC_MAP_METALNESS,       // Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
  SHADER_LOC_MAP_NORMAL,          // Shader location: sampler2d texture: normal
  SHADER_LOC_MAP_ROUGHNESS,       // Shader location: sampler2d texture: roughness
  SHADER_LOC_MAP_OCCLUSION,       // Shader location: sampler2d texture: occlusion
  SHADER_LOC_MAP_EMISSION,        // Shader location: sampler2d texture: emission
  SHADER_LOC_MAP_HEIGHT,          // Shader location: sampler2d texture: height
  SHADER_LOC_MAP_CUBEMAP,         // Shader location: samplerCube texture: cubemap
  SHADER_LOC_MAP_IRRADIANCE,      // Shader location: samplerCube texture: irradiance
  SHADER_LOC_MAP_PREFILTER,       // Shader location: samplerCube texture: prefilter
  SHADER_LOC_MAP_BRDF             // Shader location: sampler2d texture: brdf
}

// Shader uniform data type
enum ShaderUniformDataType: int {
  SHADER_UNIFORM_FLOAT = 0,       // Shader uniform type: float
  SHADER_UNIFORM_VEC2,            // Shader uniform type: vec2 (2 float)
  SHADER_UNIFORM_VEC3,            // Shader uniform type: vec3 (3 float)
  SHADER_UNIFORM_VEC4,            // Shader uniform type: vec4 (4 float)
  SHADER_UNIFORM_INT,             // Shader uniform type: int
  SHADER_UNIFORM_IVEC2,           // Shader uniform type: ivec2 (2 int)
  SHADER_UNIFORM_IVEC3,           // Shader uniform type: ivec3 (3 int)
  SHADER_UNIFORM_IVEC4,           // Shader uniform type: ivec4 (4 int)
  SHADER_UNIFORM_SAMPLER2D        // Shader uniform type: sampler2d
}

// Shader attribute data types
enum ShaderAttributeDataType: int {
  SHADER_ATTRIB_FLOAT = 0,        // Shader attribute type: float
  SHADER_ATTRIB_VEC2,             // Shader attribute type: vec2 (2 float)
  SHADER_ATTRIB_VEC3,             // Shader attribute type: vec3 (3 float)
  SHADER_ATTRIB_VEC4              // Shader attribute type: vec4 (4 float)
}

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
enum PixelFormat : int {
  PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
  PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,    // 8*2 bpp (2 channels)
  PIXELFORMAT_UNCOMPRESSED_R5G6B5,        // 16 bpp
  PIXELFORMAT_UNCOMPRESSED_R8G8B8,        // 24 bpp
  PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,      // 16 bpp (1 bit alpha)
  PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,      // 16 bpp (4 bit alpha)
  PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,      // 32 bpp
  PIXELFORMAT_UNCOMPRESSED_R32,           // 32 bpp (1 channel - float)
  PIXELFORMAT_UNCOMPRESSED_R32G32B32,     // 32*3 bpp (3 channels - float)
  PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,  // 32*4 bpp (4 channels - float)
  PIXELFORMAT_COMPRESSED_DXT1_RGB,        // 4 bpp (no alpha)
  PIXELFORMAT_COMPRESSED_DXT1_RGBA,       // 4 bpp (1 bit alpha)
  PIXELFORMAT_COMPRESSED_DXT3_RGBA,       // 8 bpp
  PIXELFORMAT_COMPRESSED_DXT5_RGBA,       // 8 bpp
  PIXELFORMAT_COMPRESSED_ETC1_RGB,        // 4 bpp
  PIXELFORMAT_COMPRESSED_ETC2_RGB,        // 4 bpp
  PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,   // 8 bpp
  PIXELFORMAT_COMPRESSED_PVRT_RGB,        // 4 bpp
  PIXELFORMAT_COMPRESSED_PVRT_RGBA,       // 4 bpp
  PIXELFORMAT_COMPRESSED_ASTC_4X4_RGBA,   // 8 bpp
  PIXELFORMAT_COMPRESSED_ASTC_8X8_RGBA    // 2 bpp
}

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
enum TextureFilter : int {
  TEXTURE_FILTER_POINT = 0,               // No filter, just pixel aproximation
  TEXTURE_FILTER_BILINEAR,                // Linear filtering
  TEXTURE_FILTER_TRILINEAR,               // Trilinear filtering (linear with mipmaps)
  TEXTURE_FILTER_ANISOTROPIC_4X,          // Anisotropic filtering 4x
  TEXTURE_FILTER_ANISOTROPIC_8X,          // Anisotropic filtering 8x
  TEXTURE_FILTER_ANISOTROPIC_16X,         // Anisotropic filtering 16x
}

// Texture parameters: wrap mode
enum TextureWrap : int{
  TEXTURE_WRAP_REPEAT = 0,                // Repeats texture in tiled mode
  TEXTURE_WRAP_CLAMP,                     // Clamps texture to edge pixel in tiled mode
  TEXTURE_WRAP_MIRROR_REPEAT,             // Mirrors and repeats the texture in tiled mode
  TEXTURE_WRAP_MIRROR_CLAMP               // Mirrors and clamps to border the texture in tiled mode
}

// Cubemap layouts
enum CubemapLayout : int{
  CUBEMAP_LAYOUT_AUTO_DETECT = 0,         // Automatically detect layout type
  CUBEMAP_LAYOUT_LINE_VERTICAL,           // Layout is defined by a vertical line with faces
  CUBEMAP_LAYOUT_LINE_HORIZONTAL,         // Layout is defined by an horizontal line with faces
  CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,     // Layout is defined by a 3x4 cross with cubemap faces
  CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE,     // Layout is defined by a 4x3 cross with cubemap faces
  CUBEMAP_LAYOUT_PANORAMA                 // Layout is defined by a panorama image (equirectangular map)
}

// Font type, defines generation method
enum FontType : int {
  FONT_DEFAULT = 0,               // Default font generation, anti-aliased
  FONT_BITMAP,                    // Bitmap font generation, no anti-aliasing
  FONT_SDF                        // SDF font generation, requires external shader
}

// Color blending modes (pre-defined)
enum BlendMode : int {
  BLEND_ALPHA = 0,                // Blend textures considering alpha (default)
  BLEND_ADDITIVE,                 // Blend textures adding colors
  BLEND_MULTIPLIED,               // Blend textures multiplying colors
  BLEND_ADD_COLORS,               // Blend textures adding colors (alternative)
  BLEND_SUBTRACT_COLORS,          // Blend textures subtracting colors (alternative)
  BLEND_CUSTOM                    // Belnd textures using custom src/dst factors (use rlSetBlendMode())
}

// Gestures
// NOTE: It could be used as flags to enable only some gestures
enum Gesture : int {
  GESTURE_NONE        = 0,        // No gesture
  GESTURE_TAP         = 1,        // Tap gesture
  GESTURE_DOUBLETAP   = 2,        // Double tap gesture
  GESTURE_HOLD        = 4,        // Hold gesture
  GESTURE_DRAG        = 8,        // Drag gesture
  GESTURE_SWIPE_RIGHT = 16,       // Swipe right gesture
  GESTURE_SWIPE_LEFT  = 32,       // Swipe left gesture
  GESTURE_SWIPE_UP    = 64,       // Swipe up gesture
  GESTURE_SWIPE_DOWN  = 128,      // Swipe down gesture
  GESTURE_PINCH_IN    = 256,      // Pinch in gesture
  GESTURE_PINCH_OUT   = 512       // Pinch out gesture
}

// Camera system modes
enum CameraMode : int {
  CAMERA_CUSTOM = 0,              // Custom camera
  CAMERA_FREE,                    // Free camera
  CAMERA_ORBITAL,                 // Orbital camera
  CAMERA_FIRST_PERSON,            // First person camera
  CAMERA_THIRD_PERSON             // Third person camera
}

// Camera projection
enum CameraProjection : int {
  CAMERA_PERSPECTIVE = 0,         // Perspective projection
  CAMERA_ORTHOGRAPHIC             // Orthographic projection
}

// N-patch layout
enum NPatchLayout : int {
    NPATCH_NINE_PATCH = 0,          // Npatch layout: 3x3 tiles
    NPATCH_THREE_PATCH_VERTICAL,    // Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_HORIZONTAL   // Npatch layout: 3x1 tiles
}

// I am excluding the callbacks that go here in raylib.h
// Here are the original C typedefs:
// typedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  // Logging: Redirect trace log messages
// typedef unsigned char *(*LoadFileDataCallback)(const char *fileName, unsigned int *bytesRead);      // FileIO: Load binary data
// typedef bool (*SaveFileDataCallback)(const char *fileName, void *data, unsigned int bytesToWrite);  // FileIO: Save binary data
// typedef char *(*LoadFileTextCallback)(const char *fileName);       // FileIO: Load text data
// typedef bool (*SaveFileTextCallback)(const char *fileName, char *text);     // FileIO: Save text data

/* -----  Math  ----- */

func float clamp(float value, float min, float max) @extname("Clamp");
func float lerp(float start, float end, float amount) @extname("Lerp");
func float normalize(float value, float start, float end) @extname("Normalize");
func float remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd) @extname("Remap");
func Vector2 vector2_zero() @extname("Vector2Zero");
func Vector2 vector2_one() @extname("Vector2One");
func Vector2 vector2_add(Vector2 v1, Vector2 v2) @extname("Vector2Add");
func Vector2 vector2_add_value(Vector2 v, float add) @extname("Vector2AddValue");
func Vector2 vector2_subtract(Vector2 v1, Vector2 v2) @extname("Vector2Subtract");
func Vector2 vector2_subtract_value(Vector2 v, float sub) @extname("Vector2SubtractValue");
func float vector2_length(Vector2 v) @extname("Vector2Length");
func float vector2_length_sqr(Vector2 v) @extname("Vector2LengthSqr");
func float vector2_dot_product(Vector2 v1, Vector2 v2) @extname("Vector2DotProduct");
func float vector2_distance(Vector2 v1, Vector2 v2) @extname("Vector2Distance");
func float vector2_angle(Vector2 v1, Vector2 v2) @extname("Vector2Angle");
func Vector2 vector2_scale(Vector2 v, float scale) @extname("Vector2Scale");
func Vector2 vector2_multiply(Vector2 v1, Vector2 v2) @extname("Vector2Multiply");
func Vector2 vector2_negate(Vector2 v) @extname("Vector2Negate");
func Vector2 vector2_divide(Vector2 v1, Vector2 v2) @extname("Vector2Divide");
func Vector2 vector2_normalize(Vector2 v) @extname("Vector2Normalize");
func Vector2 vector2_lerp(Vector2 v1, Vector2 v2, float amount) @extname("Vector2Lerp");
func Vector2 vector2_reflect(Vector2 v, Vector2 normal) @extname("Vector2Reflect");
func Vector2 vector2_rotate(Vector2 v, float degs) @extname("Vector2Rotate");
func Vector2 vector2_move_towards(Vector2 v, Vector2 target, float maxDistance) @extname("Vector2MoveTowards");
func Vector3 vector3_zero() @extname("Vector3Zero");
func Vector3 vector3_one() @extname("Vector3One");
func Vector3 vector3_add(Vector3 v1, Vector3 v2) @extname("Vector3Add");
func Vector3 vector3_add_value(Vector3 v, float add) @extname("Vector3AddValue");
func Vector3 vector3_subtract(Vector3 v1, Vector3 v2) @extname("Vector3Subtract");
func Vector3 vector3_subtract_value(Vector3 v, float sub) @extname("Vector3SubtractValue");
func Vector3 vector3_scale(Vector3 v, float scalar) @extname("Vector3Scale");
func Vector3 vector3_multiply(Vector3 v1, Vector3 v2) @extname("Vector3Multiply");
func Vector3 vector3_cross_product(Vector3 v1, Vector3 v2) @extname("Vector3CrossProduct");
func Vector3 vector3_perpendicular(Vector3 v) @extname("Vector3Perpendicular");
func float vector3_length(Vector3 v) @extname("Vector3Length");
func float vector3_length_sqr(Vector3 v) @extname("Vector3LengthSqr");
func float vector3_dot_product(Vector3 v1, Vector3 v2) @extname("Vector3DotProduct");
func float vector3_distance(Vector3 v1, Vector3 v2) @extname("Vector3Distance");
func Vector3 vector3_negate(Vector3 v) @extname("Vector3Negate");
func Vector3 vector3_divide(Vector3 v1, Vector3 v2) @extname("Vector3Divide");
func Vector3 vector3_normalize(Vector3 v) @extname("Vector3Normalize");
func void vector3_ortho_normalize(Vector3 *v1, Vector3 *v2) @extname("Vector3OrthoNormalize");
func Vector3 vector3_transform(Vector3 v, Matrix mat) @extname("Vector3Transform");
func Vector3 vector3_rotate_by_quaternion(Vector3 v, Quaternion q) @extname("Vector3RotateByQuaternion");
func Vector3 vector3_lerp(Vector3 v1, Vector3 v2, float amount) @extname("Vector3Lerp");
func Vector3 vector3_reflect(Vector3 v, Vector3 normal) @extname("Vector3Reflect");
func Vector3 vector3_min(Vector3 v1, Vector3 v2) @extname("Vector3Min");
func Vector3 vector3_max(Vector3 v1, Vector3 v2) @extname("Vector3Max");
func Vector3 vector3_barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c) @extname("Vector3Barycenter");
func float3 vector3_to_float_v(Vector3 v) @extname("Vector3ToFloatV");
func float matrix_determinant(Matrix mat) @extname("MatrixDeterminant");
func float matrix_trace(Matrix mat) @extname("MatrixTrace");
func Matrix matrix_transpose(Matrix mat) @extname("MatrixTranspose");
func Matrix matrix_invert(Matrix mat) @extname("MatrixInvert");
func Matrix matrix_normalize(Matrix mat) @extname("MatrixNormalize");
func Matrix matrix_identity() @extname("MatrixIdentity");
func Matrix matrix_add(Matrix left, Matrix right) @extname("MatrixAdd");
func Matrix matrix_subtract(Matrix left, Matrix right) @extname("MatrixSubtract");
func Matrix matrix_multiply(Matrix left, Matrix right) @extname("MatrixMultiply");
func Matrix matrix_translate(float x, float y, float z) @extname("MatrixTranslate");
func Matrix matrix_rotate(Vector3 axis, float angle) @extname("MatrixRotate");
func Matrix matrix_rotate_x(float angle) @extname("MatrixRotateX");
func Matrix matrix_rotate_y(float angle) @extname("MatrixRotateY");
func Matrix matrix_rotate_z(float angle) @extname("MatrixRotateZ");
func Matrix matrix_rotate_xyz(Vector3 ang) @extname("MatrixRotateXYZ");
func Matrix matrix_rotate_zyx(Vector3 ang) @extname("MatrixRotateZYX");
func Matrix matrix_scale(float x, float y, float z) @extname("MatrixScale");
func Matrix matrix_frustum(double left, double right, double bottom, double top, double near, double far) @extname("MatrixFrustum");
func Matrix matrix_perspective(double fovy, double aspect, double near, double far) @extname("MatrixPerspective");
func Matrix matrix_ortho(double left, double right, double bottom, double top, double near, double far) @extname("MatrixOrtho");
func Matrix matrix_look_at(Vector3 eye, Vector3 target, Vector3 up) @extname("MatrixLookAt");
func float16 matrix_to_float_v(Matrix mat) @extname("MatrixToFloatV");
func Quaternion quaternion_add(Quaternion q1, Quaternion q2) @extname("QuaternionAdd");
func Quaternion quaternion_add_value(Quaternion q, float add) @extname("QuaternionAddValue");
func Quaternion quaternion_subtract(Quaternion q1, Quaternion q2) @extname("QuaternionSubtract");
func Quaternion quaternion_subtract_value(Quaternion q, float sub) @extname("QuaternionSubtractValue");
func Quaternion quaternion_identity() @extname("QuaternionIdentity");
func float quaternion_length(Quaternion q) @extname("QuaternionLength");
func Quaternion quaternion_normalize(Quaternion q) @extname("QuaternionNormalize");
func Quaternion quaternion_invert(Quaternion q) @extname("QuaternionInvert");
func Quaternion quaternion_multiply(Quaternion q1, Quaternion q2) @extname("QuaternionMultiply");
func Quaternion quaternion_scale(Quaternion q, float mul) @extname("QuaternionScale");
func Quaternion quaternion_divide(Quaternion q1, Quaternion q2) @extname("QuaternionDivide");
func Quaternion quaternion_lerp(Quaternion q1, Quaternion q2, float amount) @extname("QuaternionLerp");
func Quaternion quaternion_nlerp(Quaternion q1, Quaternion q2, float amount) @extname("QuaternionNlerp");
func Quaternion quaternion_slerp(Quaternion q1, Quaternion q2, float amount) @extname("QuaternionSlerp");
func Quaternion quaternion_from_vector3_to_vector3(Vector3 from, Vector3 to) @extname("QuaternionFromVector3ToVector3");
func Quaternion quaternion_from_matrix(Matrix mat) @extname("QuaternionFromMatrix");
func Matrix quaternion_to_matrix(Quaternion q) @extname("QuaternionToMatrix");
func Quaternion quaternion_from_axis_angle(Vector3 axis, float angle) @extname("QuaternionFromAxisAngle");
func void quaternion_to_axis_angle(Quaternion q, Vector3 *outAxis, float *outAngle) @extname("QuaternionToAxisAngle");
func Quaternion quaternion_from_euler(float pitch, float yaw, float roll) @extname("QuaternionFromEuler");
func Vector3 quaternion_to_euler(Quaternion q) @extname("QuaternionToEuler");
func Quaternion quaternion_transform(Quaternion q, Matrix mat) @extname("QuaternionTransform");
func Vector3 vector3_unproject(Vector3 source, Matrix projection, Matrix view) @extname("Vector3Unproject");

/* ----- General ----- */

func void init_window(int width, int height, byte *title) @extname("InitWindow");
func bool window_should_close() @extname("WindowShouldClose");
func void close_window() @extname("CloseWindow");
func bool is_window_ready() @extname("IsWindowReady");
func bool is_window_fullscreen() @extname("IsWindowFullscreen");
func bool is_window_hidden() @extname("IsWindowHidden");
func bool is_window_minimized() @extname("IsWindowMinimized");
func bool is_window_maximized() @extname("IsWindowMaximized");
func bool is_window_focused() @extname("IsWindowFocused");
func bool is_window_resized() @extname("IsWindowResized");
func bool is_window_state(uint flag) @extname("IsWindowState");
func void set_window_state(uint flags) @extname("SetWindowState");
func void clear_window_state(uint flags) @extname("ClearWindowState");
func void toggle_fullscreen() @extname("ToggleFullscreen");
func void maximize_window() @extname("MaximizeWindow");
func void minimize_window() @extname("MinimizeWindow");
func void restore_window() @extname("RestoreWindow");
func void set_window_icon(Image image) @extname("SetWindowIcon");
func void set_window_title(byte *title) @extname("SetWindowTitle");
func void set_window_position(int x, int y) @extname("SetWindowPosition");
func void set_window_monitor(int monitor) @extname("SetWindowMonitor");
func void set_window_min_size(int width, int height) @extname("SetWindowMinSize");
func void set_window_size(int width, int height) @extname("SetWindowSize");
func void *_get_window_handle() @extname("*GetWindowHandle");
func int get_screen_width() @extname("GetScreenWidth");
func int get_screen_height() @extname("GetScreenHeight");
func int get_monitor_count() @extname("GetMonitorCount");
func int get_current_monitor() @extname("GetCurrentMonitor");
func Vector2 get_monitor_position(int monitor) @extname("GetMonitorPosition");
func int get_monitor_width(int monitor) @extname("GetMonitorWidth");
func int get_monitor_height(int monitor) @extname("GetMonitorHeight");
func int get_monitor_physical_width(int monitor) @extname("GetMonitorPhysicalWidth");
func int get_monitor_physical_height(int monitor) @extname("GetMonitorPhysicalHeight");
func int get_monitor_refresh_rate(int monitor) @extname("GetMonitorRefreshRate");
func Vector2 get_window_position() @extname("GetWindowPosition");
func Vector2 get_window_scale_dpi() @extname("GetWindowScaleDPI");
func byte *_get_monitor_name(int monitor) @extname("*GetMonitorName");
func void set_clipboard_text(byte *text) @extname("SetClipboardText");
func byte *_get_clipboard_text() @extname("*GetClipboardText");
func void swap_screen_buffer() @extname("SwapScreenBuffer");
func void poll_input_events() @extname("PollInputEvents");
func void wait_time(float ms) @extname("WaitTime");
func void show_cursor() @extname("ShowCursor");
func void hide_cursor() @extname("HideCursor");
func bool is_cursor_hidden() @extname("IsCursorHidden");
func void enable_cursor() @extname("EnableCursor");
func void disable_cursor() @extname("DisableCursor");
func bool is_cursor_on_screen() @extname("IsCursorOnScreen");
func void clear_background(Color color) @extname("ClearBackground");
func void begin_drawing() @extname("BeginDrawing");
func void end_drawing() @extname("EndDrawing");
func void begin_mode2_d(Camera2D camera) @extname("BeginMode2D");
func void end_mode2_d() @extname("EndMode2D");
func void begin_mode3_d(Camera3D camera) @extname("BeginMode3D");
func void end_mode3_d() @extname("EndMode3D");
func void begin_texture_mode(RenderTexture2D target) @extname("BeginTextureMode");
func void end_texture_mode() @extname("EndTextureMode");
func void begin_shader_mode(Shader shader) @extname("BeginShaderMode");
func void end_shader_mode() @extname("EndShaderMode");
func void begin_blend_mode(int mode) @extname("BeginBlendMode");
func void end_blend_mode() @extname("EndBlendMode");
func void begin_scissor_mode(int x, int y, int width, int height) @extname("BeginScissorMode");
func void end_scissor_mode() @extname("EndScissorMode");
func void begin_vr_stereo_mode(VrStereoConfig config) @extname("BeginVrStereoMode");
func void end_vr_stereo_mode() @extname("EndVrStereoMode");
func VrStereoConfig load_vr_stereo_config(VrDeviceInfo device) @extname("LoadVrStereoConfig");
func void unload_vr_stereo_config(VrStereoConfig config) @extname("UnloadVrStereoConfig");
func Shader load_shader(byte *vsFileName, byte *fsFileName) @extname("LoadShader");
func Shader load_shader_from_memory(byte *vsCode, byte *fsCode) @extname("LoadShaderFromMemory");
func int get_shader_location(Shader shader, byte *uniformName) @extname("GetShaderLocation");
func int get_shader_location_attrib(Shader shader, byte *attribName) @extname("GetShaderLocationAttrib");
func void set_shader_value(Shader shader, int locIndex, void *value, int uniformType) @extname("SetShaderValue");
func void set_shader_value_v(Shader shader, int locIndex, void *value, int uniformType, int count) @extname("SetShaderValueV");
func void set_shader_value_matrix(Shader shader, int locIndex, Matrix mat) @extname("SetShaderValueMatrix");
func void set_shader_value_texture(Shader shader, int locIndex, Texture2D texture) @extname("SetShaderValueTexture");
func void unload_shader(Shader shader) @extname("UnloadShader");
func Ray get_mouse_ray(Vector2 mousePosition, Camera camera) @extname("GetMouseRay");
func Matrix get_camera_matrix(Camera camera) @extname("GetCameraMatrix");
func Matrix get_camera_matrix2_d(Camera2D camera) @extname("GetCameraMatrix2D");
func Vector2 get_world_to_screen(Vector3 position, Camera camera) @extname("GetWorldToScreen");
func Vector2 get_world_to_screen_ex(Vector3 position, Camera camera, int width, int height) @extname("GetWorldToScreenEx");
func Vector2 get_world_to_screen2_d(Vector2 position, Camera2D camera) @extname("GetWorldToScreen2D");
func Vector2 get_screen_to_world2_d(Vector2 position, Camera2D camera) @extname("GetScreenToWorld2D");
func void set_target_fps(int fps) @extname("SetTargetFPS");
func int get_fps() @extname("GetFPS");
func float get_frame_time() @extname("GetFrameTime");
func double get_time() @extname("GetTime");
func int get_random_value(int min, int max) @extname("GetRandomValue");
func void take_screenshot(byte *fileName) @extname("TakeScreenshot");
func void set_config_flags(uint flags) @extname("SetConfigFlags");
func void trace_log(int logLevel, byte *text, ...) @extname("TraceLog");
func void set_trace_log_level(int logLevel) @extname("SetTraceLogLevel");
func void *_mem_alloc(int size) @extname("*MemAlloc");
func void *_mem_realloc(void *ptr, int size) @extname("*MemRealloc");
func void mem_free(void *ptr) @extname("MemFree");
func void set_trace_log_callback(TraceLogCallback callback) @extname("SetTraceLogCallback");
func void set_load_file_data_callback(LoadFileDataCallback callback) @extname("SetLoadFileDataCallback");
func void set_save_file_data_callback(SaveFileDataCallback callback) @extname("SetSaveFileDataCallback");
func void set_load_file_text_callback(LoadFileTextCallback callback) @extname("SetLoadFileTextCallback");
func void set_save_file_text_callback(SaveFileTextCallback callback) @extname("SetSaveFileTextCallback");
func byte *_load_file_data(byte *fileName, uint *bytesRead) @extname("*LoadFileData");
func void unload_file_data(byte *data) @extname("UnloadFileData");
func bool save_file_data(byte *fileName, void *data, uint bytesToWrite) @extname("SaveFileData");
func byte *_load_file_text(byte *fileName) @extname("*LoadFileText");
func void unload_file_text(byte *text) @extname("UnloadFileText");
func bool save_file_text(byte *fileName, byte *text) @extname("SaveFileText");
func bool file_exists(byte *fileName) @extname("FileExists");
func bool directory_exists(byte *dirPath) @extname("DirectoryExists");
func bool is_file_extension(byte *fileName, byte *ext) @extname("IsFileExtension");
func byte *_get_file_extension(byte *fileName) @extname("*GetFileExtension");
func byte *_get_file_name(byte *filePath) @extname("*GetFileName");
func byte *_get_file_name_without_ext(byte *filePath) @extname("*GetFileNameWithoutExt");
func byte *_get_directory_path(byte *filePath) @extname("*GetDirectoryPath");
func byte *_get_prev_directory_path(byte *dirPath) @extname("*GetPrevDirectoryPath");
func byte *_get_working_directory() @extname("*GetWorkingDirectory");
func byte **_get_directory_files(byte *dirPath, int *count) @extname("**GetDirectoryFiles");
func void clear_directory_files() @extname("ClearDirectoryFiles");
func bool change_directory(byte *dir) @extname("ChangeDirectory");
func bool is_file_dropped() @extname("IsFileDropped");
func byte **_get_dropped_files(int *count) @extname("**GetDroppedFiles");
func void clear_dropped_files() @extname("ClearDroppedFiles");
func long get_file_mod_time(byte *fileName) @extname("GetFileModTime");
func byte *_compress_data(byte *data, int dataLength, int *compDataLength) @extname("*CompressData");
func byte *_decompress_data(byte *compData, int compDataLength, int *dataLength) @extname("*DecompressData");
func bool save_storage_value(uint position, int value) @extname("SaveStorageValue");
func int load_storage_value(uint position) @extname("LoadStorageValue");
func void open_url(byte *url) @extname("OpenURL");
func bool is_key_pressed(KeyboardKey key) @extname("IsKeyPressed");
func bool is_key_down(KeyboardKey key) @extname("IsKeyDown");
func bool is_key_released(KeyboardKey key) @extname("IsKeyReleased");
func bool is_key_up(KeyboardKey key) @extname("IsKeyUp");
func void set_exit_key(KeyboardKey key) @extname("SetExitKey");
func int get_key_pressed() @extname("GetKeyPressed");
func int get_char_pressed() @extname("GetCharPressed");
func bool is_gamepad_available(int gamepad) @extname("IsGamepadAvailable");
func bool is_gamepad_name(int gamepad, byte *name) @extname("IsGamepadName");
func byte *_get_gamepad_name(int gamepad) @extname("*GetGamepadName");
func bool is_gamepad_button_pressed(int gamepad, MouseButton button) @extname("IsGamepadButtonPressed");
func bool is_gamepad_button_down(int gamepad, MouseButton button) @extname("IsGamepadButtonDown");
func bool is_gamepad_button_released(int gamepad, MouseButton button) @extname("IsGamepadButtonReleased");
func bool is_gamepad_button_up(int gamepad, MouseButton button) @extname("IsGamepadButtonUp");
func int get_gamepad_button_pressed() @extname("GetGamepadButtonPressed");
func int get_gamepad_axis_count(int gamepad) @extname("GetGamepadAxisCount");
func float get_gamepad_axis_movement(int gamepad, int axis) @extname("GetGamepadAxisMovement");
func int set_gamepad_mappings(byte *mappings) @extname("SetGamepadMappings");
func bool is_mouse_button_pressed(MouseButton button) @extname("IsMouseButtonPressed");
func bool is_mouse_button_down(MouseButton button) @extname("IsMouseButtonDown");
func bool is_mouse_button_released(MouseButton button) @extname("IsMouseButtonReleased");
func bool is_mouse_button_up(MouseButton button) @extname("IsMouseButtonUp");
func int get_mouse_x() @extname("GetMouseX");
func int get_mouse_y() @extname("GetMouseY");
func Vector2 get_mouse_position() @extname("GetMousePosition");
func Vector2 get_mouse_delta() @extname("GetMouseDelta");
func void set_mouse_position(int x, int y) @extname("SetMousePosition");
func void set_mouse_offset(int offsetX, int offsetY) @extname("SetMouseOffset");
func void set_mouse_scale(float scaleX, float scaleY) @extname("SetMouseScale");
func float get_mouse_wheel_move() @extname("GetMouseWheelMove");
func void set_mouse_cursor(int cursor) @extname("SetMouseCursor");
func int get_touch_x() @extname("GetTouchX");
func int get_touch_y() @extname("GetTouchY");
func Vector2 get_touch_position(int index) @extname("GetTouchPosition");
func void set_gestures_enabled(uint flags) @extname("SetGesturesEnabled");
func bool is_gesture_detected(int gesture) @extname("IsGestureDetected");
func int get_gesture_detected() @extname("GetGestureDetected");
func int get_touch_points_count() @extname("GetTouchPointsCount");
func float get_gesture_hold_duration() @extname("GetGestureHoldDuration");
func Vector2 get_gesture_drag_vector() @extname("GetGestureDragVector");
func float get_gesture_drag_angle() @extname("GetGestureDragAngle");
func Vector2 get_gesture_pinch_vector() @extname("GetGesturePinchVector");
func float get_gesture_pinch_angle() @extname("GetGesturePinchAngle");
func void set_camera_mode(Camera camera, CameraMode mode) @extname("SetCameraMode");
func void update_camera(Camera *camera) @extname("UpdateCamera");
func void set_camera_pan_control(int keyPan) @extname("SetCameraPanControl");
func void set_camera_alt_control(int keyAlt) @extname("SetCameraAltControl");
func void set_camera_smooth_zoom_control(int keySmoothZoom) @extname("SetCameraSmoothZoomControl");
func void set_camera_move_controls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown) @extname("SetCameraMoveControls");
func void set_shapes_texture(Texture2D texture, Rectangle source) @extname("SetShapesTexture");
func void draw_pixel(int posX, int posY, Color color) @extname("DrawPixel");
func void draw_pixel_v(Vector2 position, Color color) @extname("DrawPixelV");
func void draw_line(int startPosX, int startPosY, int endPosX, int endPosY, Color color) @extname("DrawLine");
func void draw_line_v(Vector2 startPos, Vector2 endPos, Color color) @extname("DrawLineV");
func void draw_line_ex(Vector2 startPos, Vector2 endPos, float thick, Color color) @extname("DrawLineEx");
func void draw_line_bezier(Vector2 startPos, Vector2 endPos, float thick, Color color) @extname("DrawLineBezier");
func void draw_line_bezier_quad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color) @extname("DrawLineBezierQuad");
func void draw_line_strip(Vector2 *points, int pointsCount, Color color) @extname("DrawLineStrip");
func void draw_circle(int centerX, int centerY, float radius, Color color) @extname("DrawCircle");
func void draw_circle_sector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color) @extname("DrawCircleSector");
func void draw_circle_sector_lines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color) @extname("DrawCircleSectorLines");
func void draw_circle_gradient(int centerX, int centerY, float radius, Color color1, Color color2) @extname("DrawCircleGradient");
func void draw_circle_v(Vector2 center, float radius, Color color) @extname("DrawCircleV");
func void draw_circle_lines(int centerX, int centerY, float radius, Color color) @extname("DrawCircleLines");
func void draw_ellipse(int centerX, int centerY, float radiusH, float radiusV, Color color) @extname("DrawEllipse");
func void draw_ellipse_lines(int centerX, int centerY, float radiusH, float radiusV, Color color) @extname("DrawEllipseLines");
func void draw_ring(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color) @extname("DrawRing");
func void draw_ring_lines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color) @extname("DrawRingLines");
func void draw_rectangle(int posX, int posY, int width, int height, Color color) @extname("DrawRectangle");
func void draw_rectangle_v(Vector2 position, Vector2 size, Color color) @extname("DrawRectangleV");
func void draw_rectangle_rec(Rectangle rec, Color color) @extname("DrawRectangleRec");
func void draw_rectangle_pro(Rectangle rec, Vector2 origin, float rotation, Color color) @extname("DrawRectanglePro");
func void draw_rectangle_gradient_v(int posX, int posY, int width, int height, Color color1, Color color2) @extname("DrawRectangleGradientV");
func void draw_rectangle_gradient_h(int posX, int posY, int width, int height, Color color1, Color color2) @extname("DrawRectangleGradientH");
func void draw_rectangle_gradient_ex(Rectangle rec, Color col1, Color col2, Color col3, Color col4) @extname("DrawRectangleGradientEx");
func void draw_rectangle_lines(int posX, int posY, int width, int height, Color color) @extname("DrawRectangleLines");
func void draw_rectangle_lines_ex(Rectangle rec, float lineThick, Color color) @extname("DrawRectangleLinesEx");
func void draw_rectangle_rounded(Rectangle rec, float roundness, int segments, Color color) @extname("DrawRectangleRounded");
func void draw_rectangle_rounded_lines(Rectangle rec, float roundness, int segments, float lineThick, Color color) @extname("DrawRectangleRoundedLines");
func void draw_triangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extname("DrawTriangle");
func void draw_triangle_lines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extname("DrawTriangleLines");
func void draw_triangle_fan(Vector2 *points, int pointsCount, Color color) @extname("DrawTriangleFan");
func void draw_triangle_strip(Vector2 *points, int pointsCount, Color color) @extname("DrawTriangleStrip");
func void draw_poly(Vector2 center, int sides, float radius, float rotation, Color color) @extname("DrawPoly");
func void draw_poly_lines(Vector2 center, int sides, float radius, float rotation, Color color) @extname("DrawPolyLines");
func void draw_poly_lines_ex(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color) @extname("DrawPolyLinesEx");
func bool check_collision_recs(Rectangle rec1, Rectangle rec2) @extname("CheckCollisionRecs");
func bool check_collision_circles(Vector2 center1, float radius1, Vector2 center2, float radius2) @extname("CheckCollisionCircles");
func bool check_collision_circle_rec(Vector2 center, float radius, Rectangle rec) @extname("CheckCollisionCircleRec");
func bool check_collision_point_rec(Vector2 point, Rectangle rec) @extname("CheckCollisionPointRec");
func bool check_collision_point_circle(Vector2 point, Vector2 center, float radius) @extname("CheckCollisionPointCircle");
func bool check_collision_point_triangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3) @extname("CheckCollisionPointTriangle");
func bool check_collision_lines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint) @extname("CheckCollisionLines");
func Rectangle get_collision_rec(Rectangle rec1, Rectangle rec2) @extname("GetCollisionRec");
func Image load_image(byte *fileName) @extname("LoadImage");
func Image load_image_raw(byte *fileName, int width, int height, int format, int headerSize) @extname("LoadImageRaw");
func Image load_image_anim(byte *fileName, int *frames) @extname("LoadImageAnim");
func Image load_image_from_memory(byte *fileType, byte *fileData, int dataSize) @extname("LoadImageFromMemory");
func Image load_image_from_texture(Texture2D texture) @extname("LoadImageFromTexture");
func Image load_image_from_screen() @extname("LoadImageFromScreen");
func void unload_image(Image image) @extname("UnloadImage");
func bool export_image(Image image, byte *fileName) @extname("ExportImage");
func bool export_image_as_code(Image image, byte *fileName) @extname("ExportImageAsCode");
func Image gen_image_color(int width, int height, Color color) @extname("GenImageColor");
func Image gen_image_gradient_v(int width, int height, Color top, Color bottom) @extname("GenImageGradientV");
func Image gen_image_gradient_h(int width, int height, Color left, Color right) @extname("GenImageGradientH");
func Image gen_image_gradient_radial(int width, int height, float density, Color inner, Color outer) @extname("GenImageGradientRadial");
func Image gen_image_checked(int width, int height, int checksX, int checksY, Color col1, Color col2) @extname("GenImageChecked");
func Image gen_image_white_noise(int width, int height, float factor) @extname("GenImageWhiteNoise");
func Image gen_image_perlin_noise(int width, int height, int offsetX, int offsetY, float scale) @extname("GenImagePerlinNoise");
func Image gen_image_cellular(int width, int height, int tileSize) @extname("GenImageCellular");
func Image image_copy(Image image) @extname("ImageCopy");
func Image image_from_image(Image image, Rectangle rec) @extname("ImageFromImage");
func Image image_text(byte *text, int fontSize, Color color) @extname("ImageText");
func Image image_text_ex(Font font, byte *text, float fontSize, float spacing, Color tint) @extname("ImageTextEx");
func void image_format(Image *image, int newFormat) @extname("ImageFormat");
func void image_to_pot(Image *image, Color fill) @extname("ImageToPOT");
func void image_crop(Image *image, Rectangle crop) @extname("ImageCrop");
func void image_alpha_crop(Image *image, float threshold) @extname("ImageAlphaCrop");
func void image_alpha_clear(Image *image, Color color, float threshold) @extname("ImageAlphaClear");
func void image_alpha_mask(Image *image, Image alphaMask) @extname("ImageAlphaMask");
func void image_alpha_premultiply(Image *image) @extname("ImageAlphaPremultiply");
func void image_resize(Image *image, int newWidth, int newHeight) @extname("ImageResize");
func void image_resize_nn(Image *image, int newWidth,int newHeight) @extname("ImageResizeNN");
func void image_resize_canvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill) @extname("ImageResizeCanvas");
func void image_mipmaps(Image *image) @extname("ImageMipmaps");
func void image_dither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp) @extname("ImageDither");
func void image_flip_vertical(Image *image) @extname("ImageFlipVertical");
func void image_flip_horizontal(Image *image) @extname("ImageFlipHorizontal");
func void image_rotate_cw(Image *image) @extname("ImageRotateCW");
func void image_rotate_ccw(Image *image) @extname("ImageRotateCCW");
func void image_color_tint(Image *image, Color color) @extname("ImageColorTint");
func void image_color_invert(Image *image) @extname("ImageColorInvert");
func void image_color_grayscale(Image *image) @extname("ImageColorGrayscale");
func void image_color_contrast(Image *image, float contrast) @extname("ImageColorContrast");
func void image_color_brightness(Image *image, int brightness) @extname("ImageColorBrightness");
func void image_color_replace(Image *image, Color color, Color replace) @extname("ImageColorReplace");
func Color *_load_image_colors(Image image) @extname("*LoadImageColors");
func Color *_load_image_palette(Image image, int maxPaletteSize, int *colorsCount) @extname("*LoadImagePalette");
func void unload_image_colors(Color *colors) @extname("UnloadImageColors");
func void unload_image_palette(Color *colors) @extname("UnloadImagePalette");
func Rectangle get_image_alpha_border(Image image, float threshold) @extname("GetImageAlphaBorder");
func void image_clear_background(Image *dst, Color color) @extname("ImageClearBackground");
func void image_draw_pixel(Image *dst, int posX, int posY, Color color) @extname("ImageDrawPixel");
func void image_draw_pixel_v(Image *dst, Vector2 position, Color color) @extname("ImageDrawPixelV");
func void image_draw_line(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color) @extname("ImageDrawLine");
func void image_draw_line_v(Image *dst, Vector2 start, Vector2 end, Color color) @extname("ImageDrawLineV");
func void image_draw_circle(Image *dst, int centerX, int centerY, int radius, Color color) @extname("ImageDrawCircle");
func void image_draw_circle_v(Image *dst, Vector2 center, int radius, Color color) @extname("ImageDrawCircleV");
func void image_draw_rectangle(Image *dst, int posX, int posY, int width, int height, Color color) @extname("ImageDrawRectangle");
func void image_draw_rectangle_v(Image *dst, Vector2 position, Vector2 size, Color color) @extname("ImageDrawRectangleV");
func void image_draw_rectangle_rec(Image *dst, Rectangle rec, Color color) @extname("ImageDrawRectangleRec");
func void image_draw_rectangle_lines(Image *dst, Rectangle rec, int thick, Color color) @extname("ImageDrawRectangleLines");
func void image_draw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint) @extname("ImageDraw");
func void image_draw_text(Image *dst, byte *text, int posX, int posY, int fontSize, Color color) @extname("ImageDrawText");
func void image_draw_text_ex(Image *dst, Font font, byte *text, Vector2 position, float fontSize, float spacing, Color tint) @extname("ImageDrawTextEx");
func Texture2D load_texture(byte *fileName) @extname("LoadTexture");
func Texture2D load_texture_from_image(Image image) @extname("LoadTextureFromImage");
func TextureCubemap load_texture_cubemap(Image image, int layout) @extname("LoadTextureCubemap");
func RenderTexture2D load_render_texture(int width, int height) @extname("LoadRenderTexture");
func void unload_texture(Texture2D texture) @extname("UnloadTexture");
func void unload_render_texture(RenderTexture2D target) @extname("UnloadRenderTexture");
func void update_texture(Texture2D texture, void *pixels) @extname("UpdateTexture");
func void update_texture_rec(Texture2D texture, Rectangle rec, void *pixels) @extname("UpdateTextureRec");
func void gen_texture_mipmaps(Texture2D *texture) @extname("GenTextureMipmaps");
func void set_texture_filter(Texture2D texture, int filter) @extname("SetTextureFilter");
func void set_texture_wrap(Texture2D texture, int wrap) @extname("SetTextureWrap");
func void draw_texture(Texture2D texture, int posX, int posY, Color tint) @extname("DrawTexture");
func void draw_texture_v(Texture2D texture, Vector2 position, Color tint) @extname("DrawTextureV");
func void draw_texture_ex(Texture2D texture, Vector2 position, float rotation, float scale, Color tint) @extname("DrawTextureEx");
func void draw_texture_rec(Texture2D texture, Rectangle source, Vector2 position, Color tint) @extname("DrawTextureRec");
func void draw_texture_quad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint) @extname("DrawTextureQuad");
func void draw_texture_tiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint) @extname("DrawTextureTiled");
func void draw_texture_pro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) @extname("DrawTexturePro");
func void draw_texture_n_patch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint) @extname("DrawTextureNPatch");
func void draw_texture_poly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointsCount, Color tint) @extname("DrawTexturePoly");
func Color fade(Color color, float alpha) @extname("Fade");
func int color_to_int(Color color) @extname("ColorToInt");
func Vector4 color_normalize(Color color) @extname("ColorNormalize");
func Color color_from_normalized(Vector4 normalized) @extname("ColorFromNormalized");
func Vector3 color_to_hsv(Color color) @extname("ColorToHSV");
func Color color_from_hsv(float hue, float saturation, float value) @extname("ColorFromHSV");
func Color color_alpha(Color color, float alpha) @extname("ColorAlpha");
func Color color_alpha_blend(Color dst, Color src, Color tint) @extname("ColorAlphaBlend");
func Color get_color(int hexValue) @extname("GetColor");
func Color get_pixel_color(void *srcPtr, int format) @extname("GetPixelColor");
func void set_pixel_color(void *dstPtr, Color color, int format) @extname("SetPixelColor");
func int get_pixel_data_size(int width, int height, int format) @extname("GetPixelDataSize");
func Font get_font_default() @extname("GetFontDefault");
func Font load_font(byte *fileName) @extname("LoadFont");
func Font load_font_ex(byte *fileName, int fontSize, int *fontChars, int charsCount) @extname("LoadFontEx");
func Font load_font_from_image(Image image, Color key, int firstChar) @extname("LoadFontFromImage");
func Font load_font_from_memory(byte *fileType, byte *fileData, int dataSize, int fontSize, int *fontChars, int charsCount) @extname("LoadFontFromMemory");
func CharInfo *_load_font_data(byte *fileData, int dataSize, int fontSize, int *fontChars, int charsCount, int type) @extname("*LoadFontData");
func Image gen_image_font_atlas(CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod) @extname("GenImageFontAtlas");
func void unload_font_data(CharInfo *chars, int charsCount) @extname("UnloadFontData");
func void unload_font(Font font) @extname("UnloadFont");
func void draw_fps(int posX, int posY) @extname("DrawFPS");
func void draw_text(byte *text, int posX, int posY, int fontSize, Color color) @extname("DrawText");
func void draw_text_ex(Font font, byte *text, Vector2 position, float fontSize, float spacing, Color tint) @extname("DrawTextEx");
func void draw_text_rec(Font font, byte *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint) @extname("DrawTextRec");
func void draw_text_rec_ex(Font font, byte *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint, int selectStart, int selectLength, Color selectTint, Color selectBackTint) @extname("DrawTextRecEx");
func void draw_text_codepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint) @extname("DrawTextCodepoint");
func int measure_text(byte *text, int fontSize) @extname("MeasureText");
func Vector2 measure_text_ex(Font font, byte *text, float fontSize, float spacing) @extname("MeasureTextEx");
func int get_glyph_index(Font font, int codepoint) @extname("GetGlyphIndex");
func int text_copy(byte *dst, byte *src) @extname("TextCopy");
func bool text_is_equal(byte *text1, byte *text2) @extname("TextIsEqual");
func uint text_length(byte *text) @extname("TextLength");
func byte *_text_format(byte *text, ...) @extname("*TextFormat");
func byte *_text_subtext(byte *text, int position, int length) @extname("*TextSubtext");
func byte *_text_replace(byte *text, byte *replace, byte *by) @extname("*TextReplace");
func byte *_text_insert(byte *text, byte *insert, int position) @extname("*TextInsert");
func byte *_text_join(byte **textList, int count, byte *delimiter) @extname("*TextJoin");
func byte **_text_split(byte *text, byte delimiter, int *count) @extname("**TextSplit");
func void text_append(byte *text, byte *append, int *position) @extname("TextAppend");
func int text_find_index(byte *text, byte *find) @extname("TextFindIndex");
func byte *_text_to_upper(byte *text) @extname("*TextToUpper");
func byte *_text_to_lower(byte *text) @extname("*TextToLower");
func byte *_text_to_pascal(byte *text) @extname("*TextToPascal");
func int text_to_integer(byte *text) @extname("TextToInteger");
func byte *_text_to_utf8(int *codepoints, int length) @extname("*TextToUtf8");
func int *_load_codepoints(byte *text, int *count) @extname("*LoadCodepoints");
func void unload_codepoints(int *codepoints) @extname("UnloadCodepoints");
func int get_codepoints_count(byte *text) @extname("GetCodepointsCount");
func int get_codepoint(byte *text, int *bytesProcessed) @extname("GetCodepoint");
func byte *_codepoint_to_utf8(int codepoint, int *byteLength) @extname("*CodepointToUtf8");
func void draw_line3_d(Vector3 startPos, Vector3 endPos, Color color) @extname("DrawLine3D");
func void draw_point3_d(Vector3 position, Color color) @extname("DrawPoint3D");
func void draw_circle3_d(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color) @extname("DrawCircle3D");
func void draw_triangle3_d(Vector3 v1, Vector3 v2, Vector3 v3, Color color) @extname("DrawTriangle3D");
func void draw_triangle_strip3_d(Vector3 *points, int pointsCount, Color color) @extname("DrawTriangleStrip3D");
func void draw_cube(Vector3 position, float width, float height, float length, Color color) @extname("DrawCube");
func void draw_cube_v(Vector3 position, Vector3 size, Color color) @extname("DrawCubeV");
func void draw_cube_wires(Vector3 position, float width, float height, float length, Color color) @extname("DrawCubeWires");
func void draw_cube_wires_v(Vector3 position, Vector3 size, Color color) @extname("DrawCubeWiresV");
func void draw_cube_texture(Texture2D texture, Vector3 position, float width, float height, float length, Color color) @extname("DrawCubeTexture");
func void draw_sphere(Vector3 centerPos, float radius, Color color) @extname("DrawSphere");
func void draw_sphere_ex(Vector3 centerPos, float radius, int rings, int slices, Color color) @extname("DrawSphereEx");
func void draw_sphere_wires(Vector3 centerPos, float radius, int rings, int slices, Color color) @extname("DrawSphereWires");
func void draw_cylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color) @extname("DrawCylinder");
func void draw_cylinder_wires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color) @extname("DrawCylinderWires");
func void draw_plane(Vector3 centerPos, Vector2 size, Color color) @extname("DrawPlane");
func void draw_ray(Ray ray, Color color) @extname("DrawRay");
func void draw_grid(int slices, float spacing) @extname("DrawGrid");
func Model load_model(byte *fileName) @extname("LoadModel");
func Model load_model_from_mesh(Mesh mesh) @extname("LoadModelFromMesh");
func void unload_model(Model model) @extname("UnloadModel");
func void unload_model_keep_meshes(Model model) @extname("UnloadModelKeepMeshes");
func BoundingBox get_model_bounding_box(Model model) @extname("GetModelBoundingBox");
func void draw_model(Model model, Vector3 position, float scale, Color tint) @extname("DrawModel");
func void draw_model_ex(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) @extname("DrawModelEx");
func void draw_model_wires(Model model, Vector3 position, float scale, Color tint) @extname("DrawModelWires");
func void draw_model_wires_ex(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint) @extname("DrawModelWiresEx");
func void draw_bounding_box(BoundingBox box, Color color) @extname("DrawBoundingBox");
func void draw_billboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint) @extname("DrawBillboard");
func void draw_billboard_rec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint) @extname("DrawBillboardRec");
func void draw_billboard_pro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Vector2 origin, float rotation, Color tint) @extname("DrawBillboardPro");
func void upload_mesh(Mesh *mesh, bool dynamic) @extname("UploadMesh");
func void update_mesh_buffer(Mesh mesh, int index, void *data, int dataSize, int offset) @extname("UpdateMeshBuffer");
func void unload_mesh(Mesh mesh) @extname("UnloadMesh");
func void draw_mesh(Mesh mesh, Material material, Matrix transform) @extname("DrawMesh");
func void draw_mesh_instanced(Mesh mesh, Material material, Matrix *transforms, int instances) @extname("DrawMeshInstanced");
func bool export_mesh(Mesh mesh, byte *fileName) @extname("ExportMesh");
func BoundingBox get_mesh_bounding_box(Mesh mesh) @extname("GetMeshBoundingBox");
func void gen_mesh_tangents(Mesh *mesh) @extname("GenMeshTangents");
func void gen_mesh_binormals(Mesh *mesh) @extname("GenMeshBinormals");
func Mesh gen_mesh_poly(int sides, float radius) @extname("GenMeshPoly");
func Mesh gen_mesh_plane(float width, float length, int resX, int resZ) @extname("GenMeshPlane");
func Mesh gen_mesh_cube(float width, float height, float length) @extname("GenMeshCube");
func Mesh gen_mesh_sphere(float radius, int rings, int slices) @extname("GenMeshSphere");
func Mesh gen_mesh_hemi_sphere(float radius, int rings, int slices) @extname("GenMeshHemiSphere");
func Mesh gen_mesh_cylinder(float radius, float height, int slices) @extname("GenMeshCylinder");
func Mesh gen_mesh_cone(float radius, float height, int slices) @extname("GenMeshCone");
func Mesh gen_mesh_torus(float radius, float size, int radSeg, int sides) @extname("GenMeshTorus");
func Mesh gen_mesh_knot(float radius, float size, int radSeg, int sides) @extname("GenMeshKnot");
func Mesh gen_mesh_heightmap(Image heightmap, Vector3 size) @extname("GenMeshHeightmap");
func Mesh gen_mesh_cubicmap(Image cubicmap, Vector3 cubeSize) @extname("GenMeshCubicmap");
func Material *_load_materials(byte *fileName, int *materialCount) @extname("*LoadMaterials");
func Material load_material_default() @extname("LoadMaterialDefault");
func void unload_material(Material material) @extname("UnloadMaterial");
func void set_material_texture(Material *material, int mapType, Texture2D texture) @extname("SetMaterialTexture");
func void set_model_mesh_material(Model *model, int meshId, int materialId) @extname("SetModelMeshMaterial");
func ModelAnimation *_load_model_animations(byte *fileName, int *animsCount) @extname("*LoadModelAnimations");
func void update_model_animation(Model model, ModelAnimation anim, int frame) @extname("UpdateModelAnimation");
func void unload_model_animation(ModelAnimation anim) @extname("UnloadModelAnimation");
func void unload_model_animations(ModelAnimation* animations, uint count) @extname("UnloadModelAnimations");
func bool is_model_animation_valid(Model model, ModelAnimation anim) @extname("IsModelAnimationValid");
func bool check_collision_spheres(Vector3 center1, float radius1, Vector3 center2, float radius2) @extname("CheckCollisionSpheres");
func bool check_collision_boxes(BoundingBox box1, BoundingBox box2) @extname("CheckCollisionBoxes");
func bool check_collision_box_sphere(BoundingBox box, Vector3 center, float radius) @extname("CheckCollisionBoxSphere");
func RayCollision get_ray_collision_sphere(Ray ray, Vector3 center, float radius) @extname("GetRayCollisionSphere");
func RayCollision get_ray_collision_box(Ray ray, BoundingBox box) @extname("GetRayCollisionBox");
func RayCollision get_ray_collision_model(Ray ray, Model model) @extname("GetRayCollisionModel");
func RayCollision get_ray_collision_mesh(Ray ray, Mesh mesh, Matrix transform) @extname("GetRayCollisionMesh");
func RayCollision get_ray_collision_triangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3) @extname("GetRayCollisionTriangle");
func RayCollision get_ray_collision_quad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) @extname("GetRayCollisionQuad");
func void init_audio_device() @extname("InitAudioDevice");
func void close_audio_device() @extname("CloseAudioDevice");
func bool is_audio_device_ready() @extname("IsAudioDeviceReady");
func void set_master_volume(float volume) @extname("SetMasterVolume");
func Wave load_wave(byte *fileName) @extname("LoadWave");
func Wave load_wave_from_memory(byte *fileType, byte *fileData, int dataSize) @extname("LoadWaveFromMemory");
func Sound load_sound(byte *fileName) @extname("LoadSound");
func Sound load_sound_from_wave(Wave wave) @extname("LoadSoundFromWave");
func void update_sound(Sound sound, void *data, int samplesCount) @extname("UpdateSound");
func void unload_wave(Wave wave) @extname("UnloadWave");
func void unload_sound(Sound sound) @extname("UnloadSound");
func bool export_wave(Wave wave, byte *fileName) @extname("ExportWave");
func bool export_wave_as_code(Wave wave, byte *fileName) @extname("ExportWaveAsCode");
func void play_sound(Sound sound) @extname("PlaySound");
func void stop_sound(Sound sound) @extname("StopSound");
func void pause_sound(Sound sound) @extname("PauseSound");
func void resume_sound(Sound sound) @extname("ResumeSound");
func void play_sound_multi(Sound sound) @extname("PlaySoundMulti");
func void stop_sound_multi() @extname("StopSoundMulti");
func int get_sounds_playing() @extname("GetSoundsPlaying");
func bool is_sound_playing(Sound sound) @extname("IsSoundPlaying");
func void set_sound_volume(Sound sound, float volume) @extname("SetSoundVolume");
func void set_sound_pitch(Sound sound, float pitch) @extname("SetSoundPitch");
func void wave_format(Wave *wave, int sampleRate, int sampleSize, int channels) @extname("WaveFormat");
func Wave wave_copy(Wave wave) @extname("WaveCopy");
func void wave_crop(Wave *wave, int initSample, int finalSample) @extname("WaveCrop");
func float *_load_wave_samples(Wave wave) @extname("*LoadWaveSamples");
func void unload_wave_samples(float *samples) @extname("UnloadWaveSamples");
func Music load_music_stream(byte *fileName) @extname("LoadMusicStream");
func Music load_music_stream_from_memory(byte *fileType, byte *data, int dataSize) @extname("LoadMusicStreamFromMemory");
func void unload_music_stream(Music music) @extname("UnloadMusicStream");
func void play_music_stream(Music music) @extname("PlayMusicStream");
func bool is_music_stream_playing(Music music) @extname("IsMusicStreamPlaying");
func void update_music_stream(Music music) @extname("UpdateMusicStream");
func void stop_music_stream(Music music) @extname("StopMusicStream");
func void pause_music_stream(Music music) @extname("PauseMusicStream");
func void resume_music_stream(Music music) @extname("ResumeMusicStream");
func void set_music_volume(Music music, float volume) @extname("SetMusicVolume");
func void set_music_pitch(Music music, float pitch) @extname("SetMusicPitch");
func float get_music_time_length(Music music) @extname("GetMusicTimeLength");
func float get_music_time_played(Music music) @extname("GetMusicTimePlayed");
func AudioStream load_audio_stream(uint sampleRate, uint sampleSize, uint channels) @extname("LoadAudioStream");
func void unload_audio_stream(AudioStream stream) @extname("UnloadAudioStream");
func void update_audio_stream(AudioStream stream, void *data, int samplesCount) @extname("UpdateAudioStream");
func bool is_audio_stream_processed(AudioStream stream) @extname("IsAudioStreamProcessed");
func void play_audio_stream(AudioStream stream) @extname("PlayAudioStream");
func void pause_audio_stream(AudioStream stream) @extname("PauseAudioStream");
func void resume_audio_stream(AudioStream stream) @extname("ResumeAudioStream");
func bool is_audio_stream_playing(AudioStream stream) @extname("IsAudioStreamPlaying");
func void stop_audio_stream(AudioStream stream) @extname("StopAudioStream");
func void set_audio_stream_volume(AudioStream stream, float volume) @extname("SetAudioStreamVolume");
func void set_audio_stream_pitch(AudioStream stream, float pitch) @extname("SetAudioStreamPitch");
func void set_audio_stream_buffer_size_default(int size) @extname("SetAudioStreamBufferSizeDefault");