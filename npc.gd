extends StaticBody2D


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var get = get_tree().get_first_node_in_group("dialoge")
		var icon = sprite_2d.sprite_frames.get_frame_texture("default", 0)
		var name = "GREEN GUY"
		
		var setup : Array
		setup.append([icon, name, self, body])
		setup.append(30)
		setup.append(3)
		setup.append([false, false, "howdy, how are yu i have a quest if u wish to accept"])
		setup.append([false, true, "no i dont wantto accpet go way and never come back"])
		setup.append([false, false, "how dare you, u r going to get bsnish ed to the never land"])
		get._print(setup)
