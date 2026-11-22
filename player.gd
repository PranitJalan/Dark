extends CharacterBody2D

@export var Gravity := 400
@export var acceleration := 200
@export var friction := 300
@export var max_speed := 700
@export var jump_strength  := 200

var direction = 1
var jump = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	get_input()
	process_movement(delta)
	move_and_slide()
	animate()

func animate():
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	if velocity.x:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	if velocity.y:
		animated_sprite_2d.play("jump_fall")
		
func get_input():
	direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump"):
		jump = true


func process_movement(delta):
	if direction:
		velocity.x = move_toward(velocity.x, max_speed*direction, acceleration*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction*delta)
	
	if is_on_floor():
		if jump:
			velocity.y -= jump_strength
	else:
		velocity.y += Gravity*delta
	jump = false
