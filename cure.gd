extends Area2D

@export var cure_radius = 0.5
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("here")
		set_deferred("monitoring", false)
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
		monitoring = false
		var level = get_tree().get_first_node_in_group("level")
		level.radius += cure_radius
		var current = level.radius - cure_radius
		var tween = create_tween()
		tween.tween_property(level, "radius", current, 20)
		
		await tween.finished
		queue_free()
