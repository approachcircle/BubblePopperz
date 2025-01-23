extends Node

enum GameMode {
	Normal,
	Limitless,
	Powerless
}

var current_game_mode = GameMode.Normal
var health = 1.0

func load_defaults():
	health = 1.0
	current_game_mode = GameMode.Normal

func _ready() -> void:
	pass
