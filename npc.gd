extends StaticBody2D


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var flip_h = false

func _ready() -> void:
	sprite_2d.flip_h = flip_h



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var get = get_tree().get_first_node_in_group("dialoge")
		var icon = sprite_2d.sprite_frames.get_frame_texture("default", 0)
		var name = "Mr. Doctor"
		var level = get_tree().get_first_node_in_group("level")
		var setup : Array
		setup.append([icon, name, self, body])
		setup.append(30)
		setup.append_array([
			5,
			[false, false, "Hey there"],
			[false, false, "Welcome to the Clinic"],
			[false, true, "Theres problem with my visison"],
			[false, false, 'Do not worry I will fix it'],
			[false, false, "I would need 5 ruins"]
		])
		await get._print(setup)
		if level.coins < 5:
			setup.append([icon, name, self, body])
		setup.append(30)
		setup.append_array([
			5,
			[false, true, "But I do not have enough"],
			[false, false, "Welcome to the Clinic"],
			[false, true, "Theres problem with my visison"],
			[false, false, 'Do not worry I will fix it'],
			[false, false, "I would need 5 ruins"]
		])
