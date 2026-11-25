extends Node2D



# Player variables
var coins = 10



var checkpoint









var radius = 0.2
var aspect_ratio
@onready var color_rect: ColorRect = $Stuff/BLINDNESS/ColorRect
var scenes : Dictionary[String, Vector2] ={
	"start" : Vector2(-200, -90),
	"backdoor" : Vector2(-400, 1400),
	"doctor" : Vector2(1350, 1400)
}
@onready var player: CharacterBody2D = $PLAYER



func _process(delta: float) -> void:
	aspect_ratio = get_viewport_rect().size.x/get_viewport_rect().size.y
	var mat = color_rect.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("radius", radius)
		mat.set_shader_parameter("aspect_ratio", aspect_ratio)



func _ready():
	#_change_scene("start")
	pass
	
func _change_scene(scene : String):
	player.position = scenes[scene]
	checkpoint = scenes[scene]
