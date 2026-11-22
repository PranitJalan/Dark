extends CanvasLayer

var dialogues : Array[String] = []
var chars_per_second := 10
@onready var label: Label = $Label
var texture : Texture
var title : String
var is_busy = false


func _print(dialouge : Array[String] = ["Here you are, i have been looking for yu everywheei have a quest close your eyes"], icon : Texture = null, name : String = "Villager", charss_per_second : int = 30):
	if not is_busy:
		dialogues = dialouge
		texture = icon
		chars_per_second = charss_per_second
		title = name
		


func _text(index):
	var text = dialogues[index]
	var tween = create_tween()
	label.text = text
	label.visible_characters = 0
	tween.tween_property(label, "visible_characters", label.get_total_character_count(), label.get_total_character_count()/chars_per_second)
