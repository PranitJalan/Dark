shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius = 0.0;
uniform float smoothness = 0.0;
uniform float aspect_ratio = 1.77777;


void fragment() {
	vec2 uv = UV - center;
	uv.x *= aspect_ratio;
	float dis = length(uv);
	
	float alpha = smoothstep(radius, radius+smoothness, dis);
	vec4 coloro = vec4(0.0, 0.0, 0.0, alpha);
	COLOR = coloro;
}
