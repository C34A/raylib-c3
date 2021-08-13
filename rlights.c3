// raylib_c3::rlights - A translation of raylib.lights to c3.
// I don't think this is particularly useful yet without rlgl.h translated.


module raylib_c3::rlights;

const int MAX_LIGHTS = 4;

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------

// Light data
struct Light {
  int type;
  Vector3 position;
  Vector3 target;
  Color color;
  bool enabled;

  // Shader locations
  int enabledLoc;
  int typeLoc;
  int posLoc;
  int targetLoc;
  int colorLoc;
}

// Light type
enum LightType {
  LIGHT_DIRECTIONAL,
  LIGHT_POINT
}

int lightsCount = 0; // current amount of created lights

// Create a light and get shader locations
func Light create_light(
  LightType type,
  Vector3 position,
  Vector3 target,
  Color color,
  Shader shader
) {
  Light light;

  if (lightsCount < MAX_LIGHTS) {
    light.enabled = true;
    light.type = type;
    light.position = position;
    light.target = target;
    light.color = color;

    // FROM RLGIHTS.H:
    // TODO: Below code doesn't look good to me,
    // it assumes a specific shader naming and structure
    // Probably this implementation could be improved
    char[32] enabledName = "lights[x].enabled\0";
    char[32] typeName = "lights[x].type\0"; // I'm not sure these need an explicit null terminator?
    char[32] posName = "lights[x].position\0";
    char[32] targetName = "lights[x].target\0";
    char[32] colorName = "lights[x].color\0";

    // Set location name [x] depending on lights count
    enabledName[7] = '0' + lightsCount;
    typeName[7] = '0' + lightsCount;
    posName[7] = '0' + lightsCount;
    targetName[7] = '0' + lightsCount;
    colorName[7] = '0' + lightsCount;

    light.enabledLoc = get_shader_location(shader, enabledName);
    light.typeLoc = get_shader_location(shader, typeName);
    light.posLoc = get_shader_location(shader, posName);
    light.targetLoc = get_shader_location(shader, targetName);
    light.colorLoc = get_shader_location(shader, colorName);

    update_light_values(shader, light);

    lightsCount++;
  }

  return light;
}

// Send light properties to shader
// NOTE: Light shader locations should be available
void UpdateLightValues(Shader shader, Light light)
{
  // Send to shader light enabled state and type
  set_shader_value(shader, light.enabledLoc, &light.enabled, SHADER_UNIFORM_INT);
  set_shader_value(shader, light.typeLoc, &light.type, SHADER_UNIFORM_INT);

  // Send to shader light position values
  float[3] position = { light.position.x, light.position.y, light.position.z };
  set_shader_value(shader, light.posLoc, position, SHADER_UNIFORM_VEC3);

  // Send to shader light target position values
  float[3] target = { light.target.x, light.target.y, light.target.z };
  set_shader_value(shader, light.targetLoc, target, SHADER_UNIFORM_VEC3);

  // Send to shader light color values
  float[4] color = {
    (float)(light.color.r)/(float)(255),
    (float)light.color.g/(float)255,
    (float)(light.color.b)/(float)(255),
    (float)light.color.a/(float)255
  };
  set_shader_value(shader, light.colorLoc, color, SHADER_UNIFORM_VEC4);
}