shader_type canvas_item;

void fragment() {
  // Load the Game of Life current state
  COLOR = texture(TEXTURE, vec2(UV.x, UV.y));

  // And add some historical state for a nice effect
  COLOR += texture(SCREEN_TEXTURE, SCREEN_UV) * 0.9;
}
