shader_type canvas_item;

void fragment() {
  // Load the Game of Life current state
  COLOR = texture(TEXTURE, UV);

  // And add some historical state for a nice effect
  COLOR += texture(SCREEN_TEXTURE, UV) * 0.1;
}
