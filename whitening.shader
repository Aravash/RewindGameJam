shader_type canvas_item;

uniform float fadescale = 5.0;

void fragment()
{
	vec4 prev_colour = texture(TEXTURE, UV);
	COLOR = vec4(prev_colour.r * fadescale, prev_colour.g * fadescale, prev_colour.b * fadescale, prev_colour.a * .8);
}