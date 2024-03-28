shader_type canvas_item;
uniform float bright_amount;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	c.rgb +=vec3(bright_amount);
	COLOR = c;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
