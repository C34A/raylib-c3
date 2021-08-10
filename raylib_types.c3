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

!replaceme_math!

/* ----- General ----- */

!replaceme_general!