extends Node

var level
func start():
	if level:
		var menu = get_tree().current_scene
		get_tree().root.remove_child(menu)
		get_tree().root.add_child(level)
		get_tree().current_scene = level
		menu.queue_free()
	else:
		get_tree().change_scene_to_file("res://Level.tscn")

func main_menu():
	level = get_tree().current_scene
	get_tree().root.remove_child(level)
	var main = load("res://main menu.tscn").instantiate()
	get_tree().root.add_child(main)
	get_tree().current_scene = main
