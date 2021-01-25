shader_type canvas_item;

// Controlled from GDscript
uniform bool mouse_pressed = false;
uniform vec2 mouse_position = vec2(0., 0.);

/**
 * procedural white noise
 */
highp float rand(vec2 co)
{
  highp float a = 12.9898;
  highp float b = 78.233;
  highp float c = 43758.5453;
  highp float dt= dot(co.xy ,vec2(a,b));
  highp float sn= mod(dt,3.14);
  return fract(sin(sn) * c);
}

float getCellContent(vec4 cc) {
  return max(cc.r, max(cc.g, cc.b)) > 0. ? 1.0 : 0.0;
}

/**
 * Given the current cells color
 * and the surrounding cell colors
 * give me the next color for my current cell
 */
vec4 getColor(vec4 cc, int count, float time) {
  float wasCellAlive = getCellContent(cc); 
  
  // When cell is alive & has either 2 or 3 neighbours
  // it will survive until the next iteration
  if (wasCellAlive > 0. && (count == 2 || count == 3)) {
    return cc;
  }

  // If the cell is dead but has 3 neighbours
  // it will spring into life
  else if (count == 3) {
    return vec4(sin(time), cos(time), 1.0, 1.0);
  }

  // For all other cases the cells are dead
  return vec4(0.0, 0.0, 0.0, 1.0);
}

/**
 * Returns the surrounding living cell count of a given UV
 */
int ca_count(in sampler2D tex, vec2 uv, vec2 pixel_size) {
  vec2 s = pixel_size;

  float modifier;
  float neighbours = 0.;
  
  for (float x = -1.; x < 2.; x++) {
    for (float y = -1.; y < 2.; y++) {

      // We don't want to add our current square
      // modifier will equal zero only when we have x=0 & y=0
      modifier = min(1., abs(x) + abs(y));

      // Add any neighbours x value (we could also use y or z)
      neighbours += getCellContent(texture(tex, uv + vec2(x, y) * pixel_size)) * modifier;
    }
  }

  return int(neighbours);
}

void fragment() {
  // We're going to be reading from the screen each iteration
  // which will give us the chain of processing from the privous
  // frame. Gaem of life is simulated based on the previous world state
  vec2 uv = SCREEN_UV;
  vec2 sz = SCREEN_PIXEL_SIZE;

  // How many alive cells do we have around the current cell?
  int count = ca_count(TEXTURE, uv, sz);

  // How far away from the mouse is the current position
  vec2 distance_to_mouse = (uv / sz) - mouse_position; 
  
  // Mouse input drawing
  if (mouse_pressed && length(distance_to_mouse) < 20.) {
    // Apply some random spread to the mouse circle
    // gives us a nicer starting draw cycle
    float col = rand(distance_to_mouse * uv * 2.);

    // Turn on pixels if value is > .5
    col = smoothstep(0.5, 0.51, col);
    
    COLOR = vec4(col, col, col, 1.0);
  }

  else
    // The meat of Game of Life is found here
    COLOR = getColor(texture(TEXTURE, uv), count, TIME);
}
