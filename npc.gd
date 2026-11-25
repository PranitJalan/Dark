extends StaticBody2D


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var flip_h = false

func _ready() -> void:
	sprite_2d.flip_h = flip_h
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var get = get_tree().get_first_node_in_group("dialoge")
		var icon = sprite_2d.sprite_frames.get_frame_texture("default", 0)
		var name = "GREEN GUY"
		
		var setup : Array
		setup.append([icon, name, self, body])
		setup.append(30)
		setup.append(15)
		setup.append([false, false, "Hey there"])
		setup.append([false, true, "I do not see well"])
		setup.append([false, false, "Well, this place has an eye plauge"])
		setup.append([false, false, 'I suggest you see my brother Mr.Doctor'])
		setup.append([false, true, "I am broke"])
		setup.append_array([[false, false, "Worry not, there are coins lying around everywhere for some reason"],
			[false, true, "Wow what a reason, the developer seems lazy"],
			[false, false, 'Yeah he is, dont mind the levels he is bad at level design'],
			[false, true, "Dont break the fourth wall"],
			[false, false, "Sorry, also your actions can have concequences so choose carefully"],
			[false, true, "Can I get a freebie?"],
			[false, false, "No"],
			[false, true, "Please, Stardance had free stickers"],
			[false, false, "3AM does not"],
			[false, true, "I will give you a 3AM hoddie"]])
			
			
			
		get._print(setup)
