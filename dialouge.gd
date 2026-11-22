extends CanvasLayer

var dialogues : Array[String] = []
var chars_per_second : float = 10.0
@onready var label: Label = $Label
var texture : Texture
var title : String
var is_busy = false
var tween : Tween
@onready var label_2: Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
@onready var label_3: Label = $Label3

func _process(delta: float) -> void:
	if is_busy:
		visible = true
		label_3.visible = not label_3.visible
	else:
		visible = false

func _ready() -> void:
	_print()



func _print(dialouge : Array[String] = ["Here you are, i have been looking for yu everywheei have a quest close your eyes", "go on do it, i m your best friend i will never ever betray you my dear hahahahahhahaha"], icon : Texture = null, name : String = "Villager", charss_per_second : int = 10):
	if not is_busy:
		is_busy = true
		dialogues = dialouge
		texture = icon
		chars_per_second = charss_per_second
		title = name
		label_2.text = title
		if texture:
			texture_rect.texture = texture
		for i in dialogues.size():
			_text(i)
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


func _text(index):
	if tween and tween.is_running():
		tween.kill()
	var text = dialogues[index]
	tween = create_tween()
	label.text = text
	label.visible_characters = 0
	print("enter")
	print(label.visible_characters)
	tween.tween_property(label, "visible_characters", label.get_total_character_count(), label.get_total_character_count()/chars_per_second)
