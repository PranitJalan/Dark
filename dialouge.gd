extends CanvasLayer


var chars_per_second : float = 10.0
@onready var label: Label = $Label
var is_busy = false
var tween : Tween
@onready var label_2: Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
@onready var label_3: Label = $Label3
var space : Tween
@export var choice : PackedScene
@onready var v_box_container: VBoxContainer = $VBoxContainer
var selected = -1

func make(number, refernce : Node2D, name):
	refernce.call_deferred(name)
	selected = number
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
func _process(delta: float) -> void:
	if is_busy:
		visible = true
		if not (space and space.is_running()):
			space = create_tween()
			var taget = 1 - label_3.modulate.a 
			space.tween_property(label_3, "modulate", Color(1, 1, 1, taget ), 1 )
	else:
		visible = false

# Structure of complete_process -
#Array [
	#Array [
		#npc_icon,
		#npc_name,
		#npc_reference,
		#player_reference
	#],
	#chars_per_second,
	#number_of_dialouges/choices = 2,
	#Array (for a choice) [
		#is_choice = true,
		#no_of_choices = 2,
		#Array [
			#Choice_statement,
			#choice_function (called on npc_reference)
		#]
		#Array [
			#Choice_statement,
			#choice_function (called on npc_reference)
		#]
	#],
	#Array (for a dialouge) [
		#is_choice = false,
		#is_player_speaking,
		#dialouge (string)
	#]
#]

func _print(complete_process : Array):
	while is_busy:
		await get_tree().process_frame
	if true:
		
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
			else:
				label_2.text = "Make a Choice"
				label_3.text = "Left Click"
				texture_rect.texture = player_icon
				label.visible_characters = 0
				var choices_number = dialouge[1]
				for choice_no in range(choices_number):
					var current_choice = dialouge[2+choice_no]
					var button = choice.instantiate()
					button.text = current_choice[0]
					v_box_container.add_child(button)
					button.pressed.connect(make.bind(choice_no, speaker, current_choice[1]))
				while not selected > -1:
					await get_tree().process_frame
				for child in v_box_container.get_children():
					child.queue_free()
				label_2.text = "You"
				label_3.text = "Space"
				_text(dialouge[2+selected][0])
				selected = -1
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
