extends Node2D


var radius = 0.2
var aspect_ratio
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect


func _process(delta: float) -> void:
	aspect_ratio = get_viewport_rect().size.x/get_viewport_rect().size.y
	var mat = color_rect.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("radius", radius)
		mat.set_shader_parameter("aspect_ratio", aspect_ratio)
