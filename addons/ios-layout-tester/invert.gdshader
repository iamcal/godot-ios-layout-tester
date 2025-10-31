shader_type canvas_item;

render_mode unshaded;
//uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	//COLOR = vec4(1.0, 0.0, 0.0, 1.0);
	//COLOR = textureLod(TEXTURE, SCREEN_UV);
	//vec4 color = texture(TEXTURE, UV);
	//COLOR = color; //vec4(1.0 - color.rgb, color.a);

	vec4 c = texture(TEXTURE, UV);
	COLOR = c;
	//c.r=1.0-c.r;
	//c.g=1.0-c.g;
	//c.b=1.0-c.b;
	//COLOR.rgba=c;
}
