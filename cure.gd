extends Area2D

@export var cure_radius = 0.5


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().get_first_node_in_group("level").radius += cure_radius
		queue_free()
