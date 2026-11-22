extends CanvasLayer


var chars_per_second : float = 10.0
@onready var label: Label = $Label
var is_busy = false
var tween : Tween
@onready var label_2: Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
@onready var label_3: Label = $Label3
var space : Tween


func _process(delta: float) -> void:
	if is_busy:
		visible = true
		if not (space and space.is_running()):
			space = create_tween()
			var taget = 1 - label_3.modulate.a 
			space.tween_property(label_3, "modulate", Color(1, 1, 1, taget ), 1 )
	else:
		visible = false


func _print(complete_process : Array):
	if not is_busy:
		process_mode = Node.PROCESS_MODE_ALWAYS
		is_busy = true
		get_tree().paused = true
		
		
		var texture : Texture = complete_process[0][0]
		var title = complete_process[0][1]
		chars_per_second = complete_process[1]
		var player =  complete_process[0][3]
		var speaker = complete_process[0][2]
		var player_icon = player.animated_sprite_2d.sprite_frames.get_frame_texture("idle", 0)
		
		
		
		
		
		
		for i in complete_process[2]:
			
			var dialouge = complete_process[3+i]
			if not dialouge[0]: 
				# if not choice
				if dialouge[1]:
					# if player
					label_2.text = "You"
					texture_rect.texture = player_icon
				else:
					#if not player
					label_2.text = title
					if texture:
						texture_rect.texture = texture
				_text(dialouge[2])
				await get_tree().process_frame
				while not Input.is_action_just_pressed("jump"):
					await get_tree().process_frame
				
				if tween and tween.is_running():
					tween.kill()
					label.visible_characters = -1
					await get_tree().process_frame
					while not Input.is_action_just_pressed("jump"):
						await get_tree().process_frame
			
			
			
				
			
		is_busy = false
		get_tree().paused = false


func _text(index):
	if tween and tween.is_running():
		tween.kill()
	var text = index
	tween = create_tween()
	label.text = text
	label.visible_characters = 0
	print("enter")
	print(label.visible_characters)
	tween.tween_property(label, "visible_characters", label.get_total_character_count(), label.get_total_character_count()/chars_per_second)
