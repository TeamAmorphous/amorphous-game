shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
  COLOR = texture(screen_texture, SCREEN_UV);
  COLOR.a = texture(TEXTURE, UV).a;
  COLOR.rgb = vec3(0.1, 0.1, 0.1);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
