shader_type canvas_item;

uniform sampler2D previous_frame;

void fragment() {
  // Load the Game of Life current state
  COLOR = texture(TEXTURE, UV);

  // And add some historical state for a nice effect
  COLOR += texture(previous_frame, UV);

  if (max(max(COLOR.r, COLOR.g), COLOR.b) < 0.05) {
    // discard;
  }

  // COLOR = vec4(1.0);
}
