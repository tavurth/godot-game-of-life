shader_type canvas_item;

void fragment() {
  vec4 col = texture(TEXTURE, vec2(UV.x, UV.y));

  COLOR.a = 1.0;
  COLOR.b = col.r;
  
  COLOR.r = col.r * sin(TIME);
  COLOR.g = col.r * cos(TIME);
}
