extends Node


func _ready() -> void:
	var main_menu: Button = get_node("MainMenu")
	main_menu.pressed.connect(func lambda(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))
