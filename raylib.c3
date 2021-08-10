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


extern func float Clamp(float value, float min, float max);
extern func float Lerp(float start, float end, float amount);
extern func float Normalize(float value, float start, float end);
extern func float Remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd);
extern func Vector2 Vector2Zero();
extern func Vector2 Vector2One();
extern func Vector2 Vector2Add(Vector2 v1, Vector2 v2);
extern func Vector2 Vector2AddValue(Vector2 v, float add);
extern func Vector2 Vector2Subtract(Vector2 v1, Vector2 v2);
extern func Vector2 Vector2SubtractValue(Vector2 v, float sub);
extern func float Vector2Length(Vector2 v);
extern func float Vector2LengthSqr(Vector2 v);
extern func float Vector2DotProduct(Vector2 v1, Vector2 v2);
extern func float Vector2Distance(Vector2 v1, Vector2 v2);
extern func float Vector2Angle(Vector2 v1, Vector2 v2);
extern func Vector2 Vector2Scale(Vector2 v, float scale);
extern func Vector2 Vector2Multiply(Vector2 v1, Vector2 v2);
extern func Vector2 Vector2Negate(Vector2 v);
extern func Vector2 Vector2Divide(Vector2 v1, Vector2 v2);
extern func Vector2 Vector2Normalize(Vector2 v);
extern func Vector2 Vector2Lerp(Vector2 v1, Vector2 v2, float amount);
extern func Vector2 Vector2Reflect(Vector2 v, Vector2 normal);
extern func Vector2 Vector2Rotate(Vector2 v, float degs);
extern func Vector2 Vector2MoveTowards(Vector2 v, Vector2 target, float maxDistance);
extern func Vector3 Vector3Zero();
extern func Vector3 Vector3One();
extern func Vector3 Vector3Add(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3AddValue(Vector3 v, float add);
extern func Vector3 Vector3Subtract(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3SubtractValue(Vector3 v, float sub);
extern func Vector3 Vector3Scale(Vector3 v, float scalar);
extern func Vector3 Vector3Multiply(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3CrossProduct(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3Perpendicular(Vector3 v);
extern func float Vector3Length(Vector3 v);
extern func float Vector3LengthSqr(Vector3 v);
extern func float Vector3DotProduct(Vector3 v1, Vector3 v2);
extern func float Vector3Distance(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3Negate(Vector3 v);
extern func Vector3 Vector3Divide(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3Normalize(Vector3 v);
extern func void Vector3OrthoNormalize(Vector3 *v1, Vector3 *v2);
extern func Vector3 Vector3Transform(Vector3 v, Matrix mat);
extern func Vector3 Vector3RotateByQuaternion(Vector3 v, Quaternion q);
extern func Vector3 Vector3Lerp(Vector3 v1, Vector3 v2, float amount);
extern func Vector3 Vector3Reflect(Vector3 v, Vector3 normal);
extern func Vector3 Vector3Min(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3Max(Vector3 v1, Vector3 v2);
extern func Vector3 Vector3Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c);
extern func float3 Vector3ToFloatV(Vector3 v);
extern func float MatrixDeterminant(Matrix mat);
extern func float MatrixTrace(Matrix mat);
extern func Matrix MatrixTranspose(Matrix mat);
extern func Matrix MatrixInvert(Matrix mat);
extern func Matrix MatrixNormalize(Matrix mat);
extern func Matrix MatrixIdentity();
extern func Matrix MatrixAdd(Matrix left, Matrix right);
extern func Matrix MatrixSubtract(Matrix left, Matrix right);
extern func Matrix MatrixMultiply(Matrix left, Matrix right);
extern func Matrix MatrixTranslate(float x, float y, float z);
extern func Matrix MatrixRotate(Vector3 axis, float angle);
extern func Matrix MatrixRotateX(float angle);
extern func Matrix MatrixRotateY(float angle);
extern func Matrix MatrixRotateZ(float angle);
extern func Matrix MatrixRotateXYZ(Vector3 ang);
extern func Matrix MatrixRotateZYX(Vector3 ang);
extern func Matrix MatrixScale(float x, float y, float z);
extern func Matrix MatrixFrustum(double left, double right, double bottom, double top, double near, double far);
extern func Matrix MatrixPerspective(double fovy, double aspect, double near, double far);
extern func Matrix MatrixOrtho(double left, double right, double bottom, double top, double near, double far);
extern func Matrix MatrixLookAt(Vector3 eye, Vector3 target, Vector3 up);
extern func float16 MatrixToFloatV(Matrix mat);
extern func Quaternion QuaternionAdd(Quaternion q1, Quaternion q2);
extern func Quaternion QuaternionAddValue(Quaternion q, float add);
extern func Quaternion QuaternionSubtract(Quaternion q1, Quaternion q2);
extern func Quaternion QuaternionSubtractValue(Quaternion q, float sub);
extern func Quaternion QuaternionIdentity();
extern func float QuaternionLength(Quaternion q);
extern func Quaternion QuaternionNormalize(Quaternion q);
extern func Quaternion QuaternionInvert(Quaternion q);
extern func Quaternion QuaternionMultiply(Quaternion q1, Quaternion q2);
extern func Quaternion QuaternionScale(Quaternion q, float mul);
extern func Quaternion QuaternionDivide(Quaternion q1, Quaternion q2);
extern func Quaternion QuaternionLerp(Quaternion q1, Quaternion q2, float amount);
extern func Quaternion QuaternionNlerp(Quaternion q1, Quaternion q2, float amount);
extern func Quaternion QuaternionSlerp(Quaternion q1, Quaternion q2, float amount);
extern func Quaternion QuaternionFromVector3ToVector3(Vector3 from, Vector3 to);
extern func Quaternion QuaternionFromMatrix(Matrix mat);
extern func Matrix QuaternionToMatrix(Quaternion q);
extern func Quaternion QuaternionFromAxisAngle(Vector3 axis, float angle);
extern func void QuaternionToAxisAngle(Quaternion q, Vector3 *outAxis, float *outAngle);
extern func Quaternion QuaternionFromEuler(float pitch, float yaw, float roll);
extern func Vector3 QuaternionToEuler(Quaternion q);
extern func Quaternion QuaternionTransform(Quaternion q, Matrix mat);
extern func Vector3 Vector3Unproject(Vector3 source, Matrix projection, Matrix view);

/* ----- General ----- */

extern func void InitWindow(int width, int height, char *title);
extern func bool WindowShouldClose();
extern func void CloseWindow();
extern func bool IsWindowReady();
extern func bool IsWindowFullscreen();
extern func bool IsWindowHidden();
extern func bool IsWindowMinimized();
extern func bool IsWindowMaximized();
extern func bool IsWindowFocused();
extern func bool IsWindowResized();
extern func bool IsWindowState(uint flag);
extern func void SetWindowState(uint flags);
extern func void ClearWindowState(uint flags);
extern func void ToggleFullscreen();
extern func void MaximizeWindow();
extern func void MinimizeWindow();
extern func void RestoreWindow();
extern func void SetWindowIcon(Image image);
extern func void SetWindowTitle(byte *title);
extern func void SetWindowPosition(int x, int y);
extern func void SetWindowMonitor(int monitor);
extern func void SetWindowMinSize(int width, int height);
extern func void SetWindowSize(int width, int height);
extern func void *GetWindowHandle();
extern func int GetScreenWidth();
extern func int GetScreenHeight();
extern func int GetMonitorCount();
extern func int GetCurrentMonitor();
extern func Vector2 GetMonitorPosition(int monitor);
extern func int GetMonitorWidth(int monitor);
extern func int GetMonitorHeight(int monitor);
extern func int GetMonitorPhysicalWidth(int monitor);
extern func int GetMonitorPhysicalHeight(int monitor);
extern func int GetMonitorRefreshRate(int monitor);
extern func Vector2 GetWindowPosition();
extern func Vector2 GetWindowScaleDPI();
extern func char *GetMonitorName(int monitor);
extern func void SetClipboardText(byte *text);
extern func char *GetClipboardText();
extern func void SwapScreenBuffer();
extern func void PollInputEvents();
extern func void WaitTime(float ms);
extern func void ShowCursor();
extern func void HideCursor();
extern func bool IsCursorHidden();
extern func void EnableCursor();
extern func void DisableCursor();
extern func bool IsCursorOnScreen();
extern func void ClearBackground(Color color);
extern func void BeginDrawing();
extern func void EndDrawing();
extern func void BeginMode2D(Camera2D camera);
extern func void EndMode2D();
extern func void BeginMode3D(Camera3D camera);
extern func void EndMode3D();
extern func void BeginTextureMode(RenderTexture2D target);
extern func void EndTextureMode();
extern func void BeginShaderMode(Shader shader);
extern func void EndShaderMode();
extern func void BeginBlendMode(int mode);
extern func void EndBlendMode();
extern func void BeginScissorMode(int x, int y, int width, int height);
extern func void EndScissorMode();
extern func void BeginVrStereoMode(VrStereoConfig config);
extern func void EndVrStereoMode();
extern func VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
extern func void UnloadVrStereoConfig(VrStereoConfig config);
extern func Shader LoadShader(byte *vsFileName, char *fsFileName);
extern func Shader LoadShaderFromMemory(byte *vsCode, char *fsCode);
extern func int GetShaderLocation(Shader shader, char *uniformName);
extern func int GetShaderLocationAttrib(Shader shader, char *attribName);
extern func void SetShaderValue(Shader shader, int locIndex, void *value, int uniformType);
extern func void SetShaderValueV(Shader shader, int locIndex, void *value, int uniformType, int count);
extern func void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);
extern func void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture);
extern func void UnloadShader(Shader shader);
extern func Ray GetMouseRay(Vector2 mousePosition, Camera camera);
extern func Matrix GetCameraMatrix(Camera camera);
extern func Matrix GetCameraMatrix2D(Camera2D camera);
extern func Vector2 GetWorldToScreen(Vector3 position, Camera camera);
extern func Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height);
extern func Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);
extern func Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);
extern func void SetTargetFPS(int fps);
extern func int GetFPS();
extern func float GetFrameTime();
extern func double GetTime();
extern func int GetRandomValue(int min, int max);
extern func void TakeScreenshot(byte *fileName);
extern func void SetConfigFlags(uint flags);
extern func void TraceLog(int logLevel, char *text, ...);
extern func void SetTraceLogLevel(int logLevel);
extern func void *MemAlloc(int size);
extern func void *MemRealloc(void *ptr, int size);
extern func void MemFree(void *ptr);
extern func void SetTraceLogCallback(TraceLogCallback callback);
extern func void SetLoadFileDataCallback(LoadFileDataCallback callback);
extern func void SetSaveFileDataCallback(SaveFileDataCallback callback);
extern func void SetLoadFileTextCallback(LoadFileTextCallback callback);
extern func void SetSaveFileTextCallback(SaveFileTextCallback callback);
extern func char *LoadFileData(byte *fileName, uint *bytesRead);
extern func void UnloadFileData(byte *data);
extern func bool SaveFileData(byte *fileName, void *data, uint bytesToWrite);
extern func char *LoadFileText(byte *fileName);
extern func void UnloadFileText(byte *text);
extern func bool SaveFileText(byte *fileName, char *text);
extern func bool FileExists(byte *fileName);
extern func bool DirectoryExists(byte *dirPath);
extern func bool IsFileExtension(byte *fileName, char *ext);
extern func char *GetFileExtension(byte *fileName);
extern func char *GetFileName(byte *filePath);
extern func char *GetFileNameWithoutExt(byte *filePath);
extern func char *GetDirectoryPath(byte *filePath);
extern func char *GetPrevDirectoryPath(byte *dirPath);
extern func char *GetWorkingDirectory();
extern func char **GetDirectoryFiles(byte *dirPath, int *count);
extern func void ClearDirectoryFiles();
extern func bool ChangeDirectory(byte *dir);
extern func bool IsFileDropped();
extern func char **GetDroppedFiles(int *count);
extern func void ClearDroppedFiles();
extern func long GetFileModTime(byte *fileName);
extern func char *CompressData(byte *data, int dataLength, int *compDataLength);
extern func char *DecompressData(byte *compData, int compDataLength, int *dataLength);
extern func bool SaveStorageValue(uint position, int value);
extern func int LoadStorageValue(uint position);
extern func void OpenURL(byte *url);
extern func bool IsKeyPressed(KeyboardKey key);
extern func bool IsKeyDown(KeyboardKey key);
extern func bool IsKeyReleased(KeyboardKey key);
extern func bool IsKeyUp(KeyboardKey key);
extern func void SetExitKey(KeyboardKey key);
extern func int GetKeyPressed();
extern func int GetCharPressed();
extern func bool IsGamepadAvailable(int gamepad);
extern func bool IsGamepadName(int gamepad, char *name);
extern func char *GetGamepadName(int gamepad);
extern func bool IsGamepadButtonPressed(int gamepad, MouseButton button);
extern func bool IsGamepadButtonDown(int gamepad, MouseButton button);
extern func bool IsGamepadButtonReleased(int gamepad, MouseButton button);
extern func bool IsGamepadButtonUp(int gamepad, MouseButton button);
extern func int GetGamepadButtonPressed();
extern func int GetGamepadAxisCount(int gamepad);
extern func float GetGamepadAxisMovement(int gamepad, int axis);
extern func int SetGamepadMappings(byte *mappings);
extern func bool IsMouseButtonPressed(MouseButton button);
extern func bool IsMouseButtonDown(MouseButton button);
extern func bool IsMouseButtonReleased(MouseButton button);
extern func bool IsMouseButtonUp(MouseButton button);
extern func int GetMouseX();
extern func int GetMouseY();
extern func Vector2 GetMousePosition();
extern func Vector2 GetMouseDelta();
extern func void SetMousePosition(int x, int y);
extern func void SetMouseOffset(int offsetX, int offsetY);
extern func void SetMouseScale(float scaleX, float scaleY);
extern func float GetMouseWheelMove();
extern func void SetMouseCursor(int cursor);
extern func int GetTouchX();
extern func int GetTouchY();
extern func Vector2 GetTouchPosition(int index);
extern func void SetGesturesEnabled(uint flags);
extern func bool IsGestureDetected(int gesture);
extern func int GetGestureDetected();
extern func int GetTouchPointsCount();
extern func float GetGestureHoldDuration();
extern func Vector2 GetGestureDragVector();
extern func float GetGestureDragAngle();
extern func Vector2 GetGesturePinchVector();
extern func float GetGesturePinchAngle();
extern func void SetCameraMode(Camera camera, CameraMode mode);
extern func void UpdateCamera(Camera *camera);
extern func void SetCameraPanControl(int keyPan);
extern func void SetCameraAltControl(int keyAlt);
extern func void SetCameraSmoothZoomControl(int keySmoothZoom);
extern func void SetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown);
extern func void SetShapesTexture(Texture2D texture, Rectangle source);
extern func void DrawPixel(int posX, int posY, Color color);
extern func void DrawPixelV(Vector2 position, Color color);
extern func void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);
extern func void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);
extern func void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);
extern func void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);
extern func void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color);
extern func void DrawLineStrip(Vector2 *points, int pointsCount, Color color);
extern func void DrawCircle(int centerX, int centerY, float radius, Color color);
extern func void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);
extern func void DrawCircleV(Vector2 center, float radius, Color color);
extern func void DrawCircleLines(int centerX, int centerY, float radius, Color color);
extern func void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);
extern func void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);
extern func void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawRectangle(int posX, int posY, int width, int height, Color color);
extern func void DrawRectangleV(Vector2 position, Vector2 size, Color color);
extern func void DrawRectangleRec(Rectangle rec, Color color);
extern func void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);
extern func void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);
extern func void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);
extern func void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);
extern func void DrawRectangleLines(int posX, int posY, int width, int height, Color color);
extern func void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);
extern func void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);
extern func void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color);
extern func void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
extern func void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
extern func void DrawTriangleFan(Vector2 *points, int pointsCount, Color color);
extern func void DrawTriangleStrip(Vector2 *points, int pointsCount, Color color);
extern func void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);
extern func void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);
extern func void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color);
extern func bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);
extern func bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);
extern func bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);
extern func bool CheckCollisionPointRec(Vector2 point, Rectangle rec);
extern func bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);
extern func bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);
extern func bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint);
extern func Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);
extern func Image LoadImage(byte *fileName);
extern func Image LoadImageRaw(byte *fileName, int width, int height, int format, int headerSize);
extern func Image LoadImageAnim(byte *fileName, int *frames);
extern func Image LoadImageFromMemory(byte *fileType, char *fileData, int dataSize);
extern func Image LoadImageFromTexture(Texture2D texture);
extern func Image LoadImageFromScreen();
extern func void UnloadImage(Image image);
extern func bool ExportImage(Image image, char *fileName);
extern func bool ExportImageAsCode(Image image, char *fileName);
extern func Image GenImageColor(int width, int height, Color color);
extern func Image GenImageGradientV(int width, int height, Color top, Color bottom);
extern func Image GenImageGradientH(int width, int height, Color left, Color right);
extern func Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);
extern func Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);
extern func Image GenImageWhiteNoise(int width, int height, float factor);
extern func Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);
extern func Image GenImageCellular(int width, int height, int tileSize);
extern func Image ImageCopy(Image image);
extern func Image ImageFromImage(Image image, Rectangle rec);
extern func Image ImageText(byte *text, int fontSize, Color color);
extern func Image ImageTextEx(Font font, char *text, float fontSize, float spacing, Color tint);
extern func void ImageFormat(Image *image, int newFormat);
extern func void ImageToPOT(Image *image, Color fill);
extern func void ImageCrop(Image *image, Rectangle crop);
extern func void ImageAlphaCrop(Image *image, float threshold);
extern func void ImageAlphaClear(Image *image, Color color, float threshold);
extern func void ImageAlphaMask(Image *image, Image alphaMask);
extern func void ImageAlphaPremultiply(Image *image);
extern func void ImageResize(Image *image, int newWidth, int newHeight);
extern func void ImageResizeNN(Image *image, int newWidth,int newHeight);
extern func void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);
extern func void ImageMipmaps(Image *image);
extern func void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);
extern func void ImageFlipVertical(Image *image);
extern func void ImageFlipHorizontal(Image *image);
extern func void ImageRotateCW(Image *image);
extern func void ImageRotateCCW(Image *image);
extern func void ImageColorTint(Image *image, Color color);
extern func void ImageColorInvert(Image *image);
extern func void ImageColorGrayscale(Image *image);
extern func void ImageColorContrast(Image *image, float contrast);
extern func void ImageColorBrightness(Image *image, int brightness);
extern func void ImageColorReplace(Image *image, Color color, Color replace);
extern func Color *LoadImageColors(Image image);
extern func Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorsCount);
extern func void UnloadImageColors(Color *colors);
extern func void UnloadImagePalette(Color *colors);
extern func Rectangle GetImageAlphaBorder(Image image, float threshold);
extern func void ImageClearBackground(Image *dst, Color color);
extern func void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
extern func void ImageDrawPixelV(Image *dst, Vector2 position, Color color);
extern func void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color);
extern func void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);
extern func void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);
extern func void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);
extern func void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);
extern func void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);
extern func void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);
extern func void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);
extern func void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);
extern func void ImageDrawText(Image *dst, char *text, int posX, int posY, int fontSize, Color color);
extern func void ImageDrawTextEx(Image *dst, Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint);
extern func Texture2D LoadTexture(byte *fileName);
extern func Texture2D LoadTextureFromImage(Image image);
extern func TextureCubemap LoadTextureCubemap(Image image, int layout);
extern func RenderTexture2D LoadRenderTexture(int width, int height);
extern func void UnloadTexture(Texture2D texture);
extern func void UnloadRenderTexture(RenderTexture2D target);
extern func void UpdateTexture(Texture2D texture, void *pixels);
extern func void UpdateTextureRec(Texture2D texture, Rectangle rec, void *pixels);
extern func void GenTextureMipmaps(Texture2D *texture);
extern func void SetTextureFilter(Texture2D texture, int filter);
extern func void SetTextureWrap(Texture2D texture, int wrap);
extern func void DrawTexture(Texture2D texture, int posX, int posY, Color tint);
extern func void DrawTextureV(Texture2D texture, Vector2 position, Color tint);
extern func void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
extern func void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
extern func void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);
extern func void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);
extern func void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
extern func void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);
extern func void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointsCount, Color tint);
extern func Color Fade(Color color, float alpha);
extern func int ColorToInt(Color color);
extern func Vector4 ColorNormalize(Color color);
extern func Color ColorFromNormalized(Vector4 normalized);
extern func Vector3 ColorToHSV(Color color);
extern func Color ColorFromHSV(float hue, float saturation, float value);
extern func Color ColorAlpha(Color color, float alpha);
extern func Color ColorAlphaBlend(Color dst, Color src, Color tint);
extern func Color GetColor(int hexValue);
extern func Color GetPixelColor(void *srcPtr, int format);
extern func void SetPixelColor(void *dstPtr, Color color, int format);
extern func int GetPixelDataSize(int width, int height, int format);
extern func Font GetFontDefault();
extern func Font LoadFont(byte *fileName);
extern func Font LoadFontEx(byte *fileName, int fontSize, int *fontChars, int charsCount);
extern func Font LoadFontFromImage(Image image, Color key, int firstChar);
extern func Font LoadFontFromMemory(byte *fileType, char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount);
extern func CharInfo *LoadFontData(byte *fileData, int dataSize, int fontSize, int *fontChars, int charsCount, int type);
extern func Image GenImageFontAtlas(CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);
extern func void UnloadFontData(CharInfo *chars, int charsCount);
extern func void UnloadFont(Font font);
extern func void DrawFPS(int posX, int posY);
extern func void DrawText(byte *text, int posX, int posY, int fontSize, Color color);
extern func void DrawTextEx(Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint);
extern func void DrawTextRec(Font font, char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint);
extern func void DrawTextRecEx(Font font, char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint, int selectStart, int selectLength, Color selectTint, Color selectBackTint);
extern func void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);
extern func int MeasureText(byte *text, int fontSize);
extern func Vector2 MeasureTextEx(Font font, char *text, float fontSize, float spacing);
extern func int GetGlyphIndex(Font font, int codepoint);
extern func int TextCopy(byte *dst, char *src);
extern func bool TextIsEqual(byte *text1, char *text2);
extern func uint TextLength(byte *text);
extern func char *TextFormat(byte *text, ...);
extern func char *TextSubtext(byte *text, int position, int length);
extern func char *TextReplace(byte *text, char *replace, char *by);
extern func char *TextInsert(byte *text, char *insert, int position);
extern func char *TextJoin(byte **textList, int count, char *delimiter);
extern func char **TextSplit(byte *text, char delimiter, int *count);
extern func void TextAppend(byte *text, char *append, int *position);
extern func int TextFindIndex(byte *text, char *find);
extern func char *TextToUpper(byte *text);
extern func char *TextToLower(byte *text);
extern func char *TextToPascal(byte *text);
extern func int TextToInteger(byte *text);
extern func char *TextToUtf8(int *codepoints, int length);
extern func int *LoadCodepoints(byte *text, int *count);
extern func void UnloadCodepoints(int *codepoints);
extern func int GetCodepointsCount(byte *text);
extern func int GetCodepoint(byte *text, int *bytesProcessed);
extern func char *CodepointToUtf8(int codepoint, int *byteLength);
extern func void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);
extern func void DrawPoint3D(Vector3 position, Color color);
extern func void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
extern func void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);
extern func void DrawTriangleStrip3D(Vector3 *points, int pointsCount, Color color);
extern func void DrawCube(Vector3 position, float width, float height, float length, Color color);
extern func void DrawCubeV(Vector3 position, Vector3 size, Color color);
extern func void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);
extern func void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);
extern func void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color);
extern func void DrawSphere(Vector3 centerPos, float radius, Color color);
extern func void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);
extern func void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);
extern func void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
extern func void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
extern func void DrawPlane(Vector3 centerPos, Vector2 size, Color color);
extern func void DrawRay(Ray ray, Color color);
extern func void DrawGrid(int slices, float spacing);
extern func Model LoadModel(byte *fileName);
extern func Model LoadModelFromMesh(Mesh mesh);
extern func void UnloadModel(Model model);
extern func void UnloadModelKeepMeshes(Model model);
extern func BoundingBox GetModelBoundingBox(Model model);
extern func void DrawModel(Model model, Vector3 position, float scale, Color tint);
extern func void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
extern func void DrawModelWires(Model model, Vector3 position, float scale, Color tint);
extern func void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
extern func void DrawBoundingBox(BoundingBox box, Color color);
extern func void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint);
extern func void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint);
extern func void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Vector2 origin, float rotation, Color tint);
extern func void UploadMesh(Mesh *mesh, bool dynamic);
extern func void UpdateMeshBuffer(Mesh mesh, int index, void *data, int dataSize, int offset);
extern func void UnloadMesh(Mesh mesh);
extern func void DrawMesh(Mesh mesh, Material material, Matrix transform);
extern func void DrawMeshInstanced(Mesh mesh, Material material, Matrix *transforms, int instances);
extern func bool ExportMesh(Mesh mesh, char *fileName);
extern func BoundingBox GetMeshBoundingBox(Mesh mesh);
extern func void GenMeshTangents(Mesh *mesh);
extern func void GenMeshBinormals(Mesh *mesh);
extern func Mesh GenMeshPoly(int sides, float radius);
extern func Mesh GenMeshPlane(float width, float length, int resX, int resZ);
extern func Mesh GenMeshCube(float width, float height, float length);
extern func Mesh GenMeshSphere(float radius, int rings, int slices);
extern func Mesh GenMeshHemiSphere(float radius, int rings, int slices);
extern func Mesh GenMeshCylinder(float radius, float height, int slices);
extern func Mesh GenMeshCone(float radius, float height, int slices);
extern func Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);
extern func Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);
extern func Mesh GenMeshHeightmap(Image heightmap, Vector3 size);
extern func Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);
extern func Material *LoadMaterials(byte *fileName, int *materialCount);
extern func Material LoadMaterialDefault();
extern func void UnloadMaterial(Material material);
extern func void SetMaterialTexture(Material *material, int mapType, Texture2D texture);
extern func void SetModelMeshMaterial(Model *model, int meshId, int materialId);
extern func ModelAnimation *LoadModelAnimations(byte *fileName, int *animsCount);
extern func void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);
extern func void UnloadModelAnimation(ModelAnimation anim);
extern func void UnloadModelAnimations(ModelAnimation* animations, uint count);
extern func bool IsModelAnimationValid(Model model, ModelAnimation anim);
extern func bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);
extern func bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);
extern func bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);
extern func RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);
extern func RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);
extern func RayCollision GetRayCollisionModel(Ray ray, Model model);
extern func RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);
extern func RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
extern func RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);
extern func void InitAudioDevice();
extern func void CloseAudioDevice();
extern func bool IsAudioDeviceReady();
extern func void SetMasterVolume(float volume);
extern func Wave LoadWave(byte *fileName);
extern func Wave LoadWaveFromMemory(byte *fileType, char *fileData, int dataSize);
extern func Sound LoadSound(byte *fileName);
extern func Sound LoadSoundFromWave(Wave wave);
extern func void UpdateSound(Sound sound, void *data, int samplesCount);
extern func void UnloadWave(Wave wave);
extern func void UnloadSound(Sound sound);
extern func bool ExportWave(Wave wave, char *fileName);
extern func bool ExportWaveAsCode(Wave wave, char *fileName);
extern func void PlaySound(Sound sound);
extern func void StopSound(Sound sound);
extern func void PauseSound(Sound sound);
extern func void ResumeSound(Sound sound);
extern func void PlaySoundMulti(Sound sound);
extern func void StopSoundMulti();
extern func int GetSoundsPlaying();
extern func bool IsSoundPlaying(Sound sound);
extern func void SetSoundVolume(Sound sound, float volume);
extern func void SetSoundPitch(Sound sound, float pitch);
extern func void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);
extern func Wave WaveCopy(Wave wave);
extern func void WaveCrop(Wave *wave, int initSample, int finalSample);
extern func float *LoadWaveSamples(Wave wave);
extern func void UnloadWaveSamples(float *samples);
extern func Music LoadMusicStream(byte *fileName);
extern func Music LoadMusicStreamFromMemory(byte *fileType, char *data, int dataSize);
extern func void UnloadMusicStream(Music music);
extern func void PlayMusicStream(Music music);
extern func bool IsMusicStreamPlaying(Music music);
extern func void UpdateMusicStream(Music music);
extern func void StopMusicStream(Music music);
extern func void PauseMusicStream(Music music);
extern func void ResumeMusicStream(Music music);
extern func void SetMusicVolume(Music music, float volume);
extern func void SetMusicPitch(Music music, float pitch);
extern func float GetMusicTimeLength(Music music);
extern func float GetMusicTimePlayed(Music music);
extern func AudioStream LoadAudioStream(uint sampleRate, uint sampleSize, uint channels);
extern func void UnloadAudioStream(AudioStream stream);
extern func void UpdateAudioStream(AudioStream stream, void *data, int samplesCount);
extern func bool IsAudioStreamProcessed(AudioStream stream);
extern func void PlayAudioStream(AudioStream stream);
extern func void PauseAudioStream(AudioStream stream);
extern func void ResumeAudioStream(AudioStream stream);
extern func bool IsAudioStreamPlaying(AudioStream stream);
extern func void StopAudioStream(AudioStream stream);
extern func void SetAudioStreamVolume(AudioStream stream, float volume);
extern func void SetAudioStreamPitch(AudioStream stream, float pitch);
extern func void SetAudioStreamBufferSizeDefault(int size);

extern func void InitWindow(int width, int height, char *title);
extern func bool WindowShouldClose();
extern func void CloseWindow();
extern func bool IsWindowReady();
extern func bool IsWindowFullscreen();
extern func bool IsWindowHidden();
extern func bool IsWindowMinimized();
extern func bool IsWindowMaximized();
extern func bool IsWindowFocused();
extern func bool IsWindowResized();
extern func bool IsWindowState(uint flag);
extern func void SetWindowState(uint flags);
extern func void ClearWindowState(uint flags);
extern func void ToggleFullscreen();
extern func void MaximizeWindow();
extern func void MinimizeWindow();
extern func void RestoreWindow();
extern func void SetWindowIcon(Image image);
extern func void SetWindowTitle(byte *title);
extern func void SetWindowPosition(int x, int y);
extern func void SetWindowMonitor(int monitor);
extern func void SetWindowMinSize(int width, int height);
extern func void SetWindowSize(int width, int height);
extern func void *GetWindowHandle();
extern func int GetScreenWidth();
extern func int GetScreenHeight();
extern func int GetMonitorCount();
extern func int GetCurrentMonitor();
extern func Vector2 GetMonitorPosition(int monitor);
extern func int GetMonitorWidth(int monitor);
extern func int GetMonitorHeight(int monitor);
extern func int GetMonitorPhysicalWidth(int monitor);
extern func int GetMonitorPhysicalHeight(int monitor);
extern func int GetMonitorRefreshRate(int monitor);
extern func Vector2 GetWindowPosition();
extern func Vector2 GetWindowScaleDPI();
extern func char *GetMonitorName(int monitor);
extern func void SetClipboardText(byte *text);
extern func char *GetClipboardText();
extern func void SwapScreenBuffer();
extern func void PollInputEvents();
extern func void WaitTime(float ms);
extern func void ShowCursor();
extern func void HideCursor();
extern func bool IsCursorHidden();
extern func void EnableCursor();
extern func void DisableCursor();
extern func bool IsCursorOnScreen();
extern func void ClearBackground(Color color);
extern func void BeginDrawing();
extern func void EndDrawing();
extern func void BeginMode2D(Camera2D camera);
extern func void EndMode2D();
extern func void BeginMode3D(Camera3D camera);
extern func void EndMode3D();
extern func void BeginTextureMode(RenderTexture2D target);
extern func void EndTextureMode();
extern func void BeginShaderMode(Shader shader);
extern func void EndShaderMode();
extern func void BeginBlendMode(int mode);
extern func void EndBlendMode();
extern func void BeginScissorMode(int x, int y, int width, int height);
extern func void EndScissorMode();
extern func void BeginVrStereoMode(VrStereoConfig config);
extern func void EndVrStereoMode();
extern func VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);
extern func void UnloadVrStereoConfig(VrStereoConfig config);
extern func Shader LoadShader(byte *vsFileName, char *fsFileName);
extern func Shader LoadShaderFromMemory(byte *vsCode, char *fsCode);
extern func int GetShaderLocation(Shader shader, char *uniformName);
extern func int GetShaderLocationAttrib(Shader shader, char *attribName);
extern func void SetShaderValue(Shader shader, int locIndex, void *value, int uniformType);
extern func void SetShaderValueV(Shader shader, int locIndex, void *value, int uniformType, int count);
extern func void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);
extern func void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture);
extern func void UnloadShader(Shader shader);
extern func Ray GetMouseRay(Vector2 mousePosition, Camera camera);
extern func Matrix GetCameraMatrix(Camera camera);
extern func Matrix GetCameraMatrix2D(Camera2D camera);
extern func Vector2 GetWorldToScreen(Vector3 position, Camera camera);
extern func Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height);
extern func Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);
extern func Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);
extern func void SetTargetFPS(int fps);
extern func int GetFPS();
extern func float GetFrameTime();
extern func double GetTime();
extern func int GetRandomValue(int min, int max);
extern func void TakeScreenshot(byte *fileName);
extern func void SetConfigFlags(uint flags);
extern func void TraceLog(int logLevel, char *text, ...);
extern func void SetTraceLogLevel(int logLevel);
extern func void *MemAlloc(int size);
extern func void *MemRealloc(void *ptr, int size);
extern func void MemFree(void *ptr);
extern func void SetTraceLogCallback(TraceLogCallback callback);
extern func void SetLoadFileDataCallback(LoadFileDataCallback callback);
extern func void SetSaveFileDataCallback(SaveFileDataCallback callback);
extern func void SetLoadFileTextCallback(LoadFileTextCallback callback);
extern func void SetSaveFileTextCallback(SaveFileTextCallback callback);
extern func char *LoadFileData(byte *fileName, uint *bytesRead);
extern func void UnloadFileData(byte *data);
extern func bool SaveFileData(byte *fileName, void *data, uint bytesToWrite);
extern func char *LoadFileText(byte *fileName);
extern func void UnloadFileText(byte *text);
extern func bool SaveFileText(byte *fileName, char *text);
extern func bool FileExists(byte *fileName);
extern func bool DirectoryExists(byte *dirPath);
extern func bool IsFileExtension(byte *fileName, char *ext);
extern func char *GetFileExtension(byte *fileName);
extern func char *GetFileName(byte *filePath);
extern func char *GetFileNameWithoutExt(byte *filePath);
extern func char *GetDirectoryPath(byte *filePath);
extern func char *GetPrevDirectoryPath(byte *dirPath);
extern func char *GetWorkingDirectory();
extern func char **GetDirectoryFiles(byte *dirPath, int *count);
extern func void ClearDirectoryFiles();
extern func bool ChangeDirectory(byte *dir);
extern func bool IsFileDropped();
extern func char **GetDroppedFiles(int *count);
extern func void ClearDroppedFiles();
extern func long GetFileModTime(byte *fileName);
extern func char *CompressData(byte *data, int dataLength, int *compDataLength);
extern func char *DecompressData(byte *compData, int compDataLength, int *dataLength);
extern func bool SaveStorageValue(uint position, int value);
extern func int LoadStorageValue(uint position);
extern func void OpenURL(byte *url);
extern func bool IsKeyPressed(KeyboardKey key);
extern func bool IsKeyDown(KeyboardKey key);
extern func bool IsKeyReleased(KeyboardKey key);
extern func bool IsKeyUp(KeyboardKey key);
extern func void SetExitKey(KeyboardKey key);
extern func int GetKeyPressed();
extern func int GetCharPressed();
extern func bool IsGamepadAvailable(int gamepad);
extern func bool IsGamepadName(int gamepad, char *name);
extern func char *GetGamepadName(int gamepad);
extern func bool IsGamepadButtonPressed(int gamepad, MouseButton button);
extern func bool IsGamepadButtonDown(int gamepad, MouseButton button);
extern func bool IsGamepadButtonReleased(int gamepad, MouseButton button);
extern func bool IsGamepadButtonUp(int gamepad, MouseButton button);
extern func int GetGamepadButtonPressed();
extern func int GetGamepadAxisCount(int gamepad);
extern func float GetGamepadAxisMovement(int gamepad, int axis);
extern func int SetGamepadMappings(byte *mappings);
extern func bool IsMouseButtonPressed(MouseButton button);
extern func bool IsMouseButtonDown(MouseButton button);
extern func bool IsMouseButtonReleased(MouseButton button);
extern func bool IsMouseButtonUp(MouseButton button);
extern func int GetMouseX();
extern func int GetMouseY();
extern func Vector2 GetMousePosition();
extern func Vector2 GetMouseDelta();
extern func void SetMousePosition(int x, int y);
extern func void SetMouseOffset(int offsetX, int offsetY);
extern func void SetMouseScale(float scaleX, float scaleY);
extern func float GetMouseWheelMove();
extern func void SetMouseCursor(int cursor);
extern func int GetTouchX();
extern func int GetTouchY();
extern func Vector2 GetTouchPosition(int index);
extern func void SetGesturesEnabled(uint flags);
extern func bool IsGestureDetected(int gesture);
extern func int GetGestureDetected();
extern func int GetTouchPointsCount();
extern func float GetGestureHoldDuration();
extern func Vector2 GetGestureDragVector();
extern func float GetGestureDragAngle();
extern func Vector2 GetGesturePinchVector();
extern func float GetGesturePinchAngle();
extern func void SetCameraMode(Camera camera, CameraMode mode);
extern func void UpdateCamera(Camera *camera);
extern func void SetCameraPanControl(int keyPan);
extern func void SetCameraAltControl(int keyAlt);
extern func void SetCameraSmoothZoomControl(int keySmoothZoom);
extern func void SetCameraMoveControls(int keyFront, int keyBack, int keyRight, int keyLeft, int keyUp, int keyDown);
extern func void SetShapesTexture(Texture2D texture, Rectangle source);
extern func void DrawPixel(int posX, int posY, Color color);
extern func void DrawPixelV(Vector2 position, Color color);
extern func void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);
extern func void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);
extern func void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);
extern func void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);
extern func void DrawLineBezierQuad(Vector2 startPos, Vector2 endPos, Vector2 controlPos, float thick, Color color);
extern func void DrawLineStrip(Vector2 *points, int pointsCount, Color color);
extern func void DrawCircle(int centerX, int centerY, float radius, Color color);
extern func void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);
extern func void DrawCircleV(Vector2 center, float radius, Color color);
extern func void DrawCircleLines(int centerX, int centerY, float radius, Color color);
extern func void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);
extern func void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);
extern func void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);
extern func void DrawRectangle(int posX, int posY, int width, int height, Color color);
extern func void DrawRectangleV(Vector2 position, Vector2 size, Color color);
extern func void DrawRectangleRec(Rectangle rec, Color color);
extern func void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);
extern func void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);
extern func void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);
extern func void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);
extern func void DrawRectangleLines(int posX, int posY, int width, int height, Color color);
extern func void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);
extern func void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);
extern func void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color);
extern func void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
extern func void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);
extern func void DrawTriangleFan(Vector2 *points, int pointsCount, Color color);
extern func void DrawTriangleStrip(Vector2 *points, int pointsCount, Color color);
extern func void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);
extern func void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);
extern func void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color);
extern func bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);
extern func bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);
extern func bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);
extern func bool CheckCollisionPointRec(Vector2 point, Rectangle rec);
extern func bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);
extern func bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);
extern func bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint);
extern func Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);
extern func Image LoadImage(byte *fileName);
extern func Image LoadImageRaw(byte *fileName, int width, int height, int format, int headerSize);
extern func Image LoadImageAnim(byte *fileName, int *frames);
extern func Image LoadImageFromMemory(byte *fileType, char *fileData, int dataSize);
extern func Image LoadImageFromTexture(Texture2D texture);
extern func Image LoadImageFromScreen();
extern func void UnloadImage(Image image);
extern func bool ExportImage(Image image, char *fileName);
extern func bool ExportImageAsCode(Image image, char *fileName);
extern func Image GenImageColor(int width, int height, Color color);
extern func Image GenImageGradientV(int width, int height, Color top, Color bottom);
extern func Image GenImageGradientH(int width, int height, Color left, Color right);
extern func Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);
extern func Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);
extern func Image GenImageWhiteNoise(int width, int height, float factor);
extern func Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);
extern func Image GenImageCellular(int width, int height, int tileSize);
extern func Image ImageCopy(Image image);
extern func Image ImageFromImage(Image image, Rectangle rec);
extern func Image ImageText(byte *text, int fontSize, Color color);
extern func Image ImageTextEx(Font font, char *text, float fontSize, float spacing, Color tint);
extern func void ImageFormat(Image *image, int newFormat);
extern func void ImageToPOT(Image *image, Color fill);
extern func void ImageCrop(Image *image, Rectangle crop);
extern func void ImageAlphaCrop(Image *image, float threshold);
extern func void ImageAlphaClear(Image *image, Color color, float threshold);
extern func void ImageAlphaMask(Image *image, Image alphaMask);
extern func void ImageAlphaPremultiply(Image *image);
extern func void ImageResize(Image *image, int newWidth, int newHeight);
extern func void ImageResizeNN(Image *image, int newWidth,int newHeight);
extern func void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill);
extern func void ImageMipmaps(Image *image);
extern func void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);
extern func void ImageFlipVertical(Image *image);
extern func void ImageFlipHorizontal(Image *image);
extern func void ImageRotateCW(Image *image);
extern func void ImageRotateCCW(Image *image);
extern func void ImageColorTint(Image *image, Color color);
extern func void ImageColorInvert(Image *image);
extern func void ImageColorGrayscale(Image *image);
extern func void ImageColorContrast(Image *image, float contrast);
extern func void ImageColorBrightness(Image *image, int brightness);
extern func void ImageColorReplace(Image *image, Color color, Color replace);
extern func Color *LoadImageColors(Image image);
extern func Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorsCount);
extern func void UnloadImageColors(Color *colors);
extern func void UnloadImagePalette(Color *colors);
extern func Rectangle GetImageAlphaBorder(Image image, float threshold);
extern func void ImageClearBackground(Image *dst, Color color);
extern func void ImageDrawPixel(Image *dst, int posX, int posY, Color color);
extern func void ImageDrawPixelV(Image *dst, Vector2 position, Color color);
extern func void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color);
extern func void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);
extern func void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);
extern func void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);
extern func void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);
extern func void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);
extern func void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);
extern func void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);
extern func void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);
extern func void ImageDrawText(Image *dst, char *text, int posX, int posY, int fontSize, Color color);
extern func void ImageDrawTextEx(Image *dst, Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint);
extern func Texture2D LoadTexture(byte *fileName);
extern func Texture2D LoadTextureFromImage(Image image);
extern func TextureCubemap LoadTextureCubemap(Image image, int layout);
extern func RenderTexture2D LoadRenderTexture(int width, int height);
extern func void UnloadTexture(Texture2D texture);
extern func void UnloadRenderTexture(RenderTexture2D target);
extern func void UpdateTexture(Texture2D texture, void *pixels);
extern func void UpdateTextureRec(Texture2D texture, Rectangle rec, void *pixels);
extern func void GenTextureMipmaps(Texture2D *texture);
extern func void SetTextureFilter(Texture2D texture, int filter);
extern func void SetTextureWrap(Texture2D texture, int wrap);
extern func void DrawTexture(Texture2D texture, int posX, int posY, Color tint);
extern func void DrawTextureV(Texture2D texture, Vector2 position, Color tint);
extern func void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
extern func void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
extern func void DrawTextureQuad(Texture2D texture, Vector2 tiling, Vector2 offset, Rectangle quad, Color tint);
extern func void DrawTextureTiled(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, float scale, Color tint);
extern func void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
extern func void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);
extern func void DrawTexturePoly(Texture2D texture, Vector2 center, Vector2 *points, Vector2 *texcoords, int pointsCount, Color tint);
extern func Color Fade(Color color, float alpha);
extern func int ColorToInt(Color color);
extern func Vector4 ColorNormalize(Color color);
extern func Color ColorFromNormalized(Vector4 normalized);
extern func Vector3 ColorToHSV(Color color);
extern func Color ColorFromHSV(float hue, float saturation, float value);
extern func Color ColorAlpha(Color color, float alpha);
extern func Color ColorAlphaBlend(Color dst, Color src, Color tint);
extern func Color GetColor(int hexValue);
extern func Color GetPixelColor(void *srcPtr, int format);
extern func void SetPixelColor(void *dstPtr, Color color, int format);
extern func int GetPixelDataSize(int width, int height, int format);
extern func Font GetFontDefault();
extern func Font LoadFont(byte *fileName);
extern func Font LoadFontEx(byte *fileName, int fontSize, int *fontChars, int charsCount);
extern func Font LoadFontFromImage(Image image, Color key, int firstChar);
extern func Font LoadFontFromMemory(byte *fileType, char *fileData, int dataSize, int fontSize, int *fontChars, int charsCount);
extern func CharInfo *LoadFontData(byte *fileData, int dataSize, int fontSize, int *fontChars, int charsCount, int type);
extern func Image GenImageFontAtlas(CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);
extern func void UnloadFontData(CharInfo *chars, int charsCount);
extern func void UnloadFont(Font font);
extern func void DrawFPS(int posX, int posY);
extern func void DrawText(byte *text, int posX, int posY, int fontSize, Color color);
extern func void DrawTextEx(Font font, char *text, Vector2 position, float fontSize, float spacing, Color tint);
extern func void DrawTextRec(Font font, char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint);
extern func void DrawTextRecEx(Font font, char *text, Rectangle rec, float fontSize, float spacing, bool wordWrap, Color tint, int selectStart, int selectLength, Color selectTint, Color selectBackTint);
extern func void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint);
extern func int MeasureText(byte *text, int fontSize);
extern func Vector2 MeasureTextEx(Font font, char *text, float fontSize, float spacing);
extern func int GetGlyphIndex(Font font, int codepoint);
extern func int TextCopy(byte *dst, char *src);
extern func bool TextIsEqual(byte *text1, char *text2);
extern func uint TextLength(byte *text);
extern func char *TextFormat(byte *text, ...);
extern func char *TextSubtext(byte *text, int position, int length);
extern func char *TextReplace(byte *text, char *replace, char *by);
extern func char *TextInsert(byte *text, char *insert, int position);
extern func char *TextJoin(byte **textList, int count, char *delimiter);
extern func char **TextSplit(byte *text, char delimiter, int *count);
extern func void TextAppend(byte *text, char *append, int *position);
extern func int TextFindIndex(byte *text, char *find);
extern func char *TextToUpper(byte *text);
extern func char *TextToLower(byte *text);
extern func char *TextToPascal(byte *text);
extern func int TextToInteger(byte *text);
extern func char *TextToUtf8(int *codepoints, int length);
extern func int *LoadCodepoints(byte *text, int *count);
extern func void UnloadCodepoints(int *codepoints);
extern func int GetCodepointsCount(byte *text);
extern func int GetCodepoint(byte *text, int *bytesProcessed);
extern func char *CodepointToUtf8(int codepoint, int *byteLength);
extern func void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);
extern func void DrawPoint3D(Vector3 position, Color color);
extern func void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color);
extern func void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);
extern func void DrawTriangleStrip3D(Vector3 *points, int pointsCount, Color color);
extern func void DrawCube(Vector3 position, float width, float height, float length, Color color);
extern func void DrawCubeV(Vector3 position, Vector3 size, Color color);
extern func void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);
extern func void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);
extern func void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color);
extern func void DrawSphere(Vector3 centerPos, float radius, Color color);
extern func void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);
extern func void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);
extern func void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
extern func void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color);
extern func void DrawPlane(Vector3 centerPos, Vector2 size, Color color);
extern func void DrawRay(Ray ray, Color color);
extern func void DrawGrid(int slices, float spacing);
extern func Model LoadModel(byte *fileName);
extern func Model LoadModelFromMesh(Mesh mesh);
extern func void UnloadModel(Model model);
extern func void UnloadModelKeepMeshes(Model model);
extern func BoundingBox GetModelBoundingBox(Model model);
extern func void DrawModel(Model model, Vector3 position, float scale, Color tint);
extern func void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
extern func void DrawModelWires(Model model, Vector3 position, float scale, Color tint);
extern func void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);
extern func void DrawBoundingBox(BoundingBox box, Color color);
extern func void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint);
extern func void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint);
extern func void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Vector2 origin, float rotation, Color tint);
extern func void UploadMesh(Mesh *mesh, bool dynamic);
extern func void UpdateMeshBuffer(Mesh mesh, int index, void *data, int dataSize, int offset);
extern func void UnloadMesh(Mesh mesh);
extern func void DrawMesh(Mesh mesh, Material material, Matrix transform);
extern func void DrawMeshInstanced(Mesh mesh, Material material, Matrix *transforms, int instances);
extern func bool ExportMesh(Mesh mesh, char *fileName);
extern func BoundingBox GetMeshBoundingBox(Mesh mesh);
extern func void GenMeshTangents(Mesh *mesh);
extern func void GenMeshBinormals(Mesh *mesh);
extern func Mesh GenMeshPoly(int sides, float radius);
extern func Mesh GenMeshPlane(float width, float length, int resX, int resZ);
extern func Mesh GenMeshCube(float width, float height, float length);
extern func Mesh GenMeshSphere(float radius, int rings, int slices);
extern func Mesh GenMeshHemiSphere(float radius, int rings, int slices);
extern func Mesh GenMeshCylinder(float radius, float height, int slices);
extern func Mesh GenMeshCone(float radius, float height, int slices);
extern func Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);
extern func Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);
extern func Mesh GenMeshHeightmap(Image heightmap, Vector3 size);
extern func Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);
extern func Material *LoadMaterials(byte *fileName, int *materialCount);
extern func Material LoadMaterialDefault();
extern func void UnloadMaterial(Material material);
extern func void SetMaterialTexture(Material *material, int mapType, Texture2D texture);
extern func void SetModelMeshMaterial(Model *model, int meshId, int materialId);
extern func ModelAnimation *LoadModelAnimations(byte *fileName, int *animsCount);
extern func void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);
extern func void UnloadModelAnimation(ModelAnimation anim);
extern func void UnloadModelAnimations(ModelAnimation* animations, uint count);
extern func bool IsModelAnimationValid(Model model, ModelAnimation anim);
extern func bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);
extern func bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);
extern func bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);
extern func RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);
extern func RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);
extern func RayCollision GetRayCollisionModel(Ray ray, Model model);
extern func RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);
extern func RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);
extern func RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);
extern func void InitAudioDevice();
extern func void CloseAudioDevice();
extern func bool IsAudioDeviceReady();
extern func void SetMasterVolume(float volume);
extern func Wave LoadWave(byte *fileName);
extern func Wave LoadWaveFromMemory(byte *fileType, char *fileData, int dataSize);
extern func Sound LoadSound(byte *fileName);
extern func Sound LoadSoundFromWave(Wave wave);
extern func void UpdateSound(Sound sound, void *data, int samplesCount);
extern func void UnloadWave(Wave wave);
extern func void UnloadSound(Sound sound);
extern func bool ExportWave(Wave wave, char *fileName);
extern func bool ExportWaveAsCode(Wave wave, char *fileName);
extern func void PlaySound(Sound sound);
extern func void StopSound(Sound sound);
extern func void PauseSound(Sound sound);
extern func void ResumeSound(Sound sound);
extern func void PlaySoundMulti(Sound sound);
extern func void StopSoundMulti();
extern func int GetSoundsPlaying();
extern func bool IsSoundPlaying(Sound sound);
extern func void SetSoundVolume(Sound sound, float volume);
extern func void SetSoundPitch(Sound sound, float pitch);
extern func void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);
extern func Wave WaveCopy(Wave wave);
extern func void WaveCrop(Wave *wave, int initSample, int finalSample);
extern func float *LoadWaveSamples(Wave wave);
extern func void UnloadWaveSamples(float *samples);
extern func Music LoadMusicStream(byte *fileName);
extern func Music LoadMusicStreamFromMemory(byte *fileType, char *data, int dataSize);
extern func void UnloadMusicStream(Music music);
extern func void PlayMusicStream(Music music);
extern func bool IsMusicStreamPlaying(Music music);
extern func void UpdateMusicStream(Music music);
extern func void StopMusicStream(Music music);
extern func void PauseMusicStream(Music music);
extern func void ResumeMusicStream(Music music);
extern func void SetMusicVolume(Music music, float volume);
extern func void SetMusicPitch(Music music, float pitch);
extern func float GetMusicTimeLength(Music music);
extern func float GetMusicTimePlayed(Music music);
extern func AudioStream LoadAudioStream(uint sampleRate, uint sampleSize, uint channels);
extern func void UnloadAudioStream(AudioStream stream);
extern func void UpdateAudioStream(AudioStream stream, void *data, int samplesCount);
extern func bool IsAudioStreamProcessed(AudioStream stream);
extern func void PlayAudioStream(AudioStream stream);
extern func void PauseAudioStream(AudioStream stream);
extern func void ResumeAudioStream(AudioStream stream);
extern func bool IsAudioStreamPlaying(AudioStream stream);
extern func void StopAudioStream(AudioStream stream);
extern func void SetAudioStreamVolume(AudioStream stream, float volume);
extern func void SetAudioStreamPitch(AudioStream stream, float pitch);
extern func void SetAudioStreamBufferSizeDefault(int size);
