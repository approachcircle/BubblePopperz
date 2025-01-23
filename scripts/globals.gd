extends Node

enum GameMode {
	Normal,
	Limitless,
	Powerless
}

enum PowerUp {
	Freeze,
	Nuke,
	Shield,
	Normal
}

var current_game_mode = GameMode.Normal
var current_power_up = PowerUp.Normal
var powerups = []
var health = 1.0

func load_defaults():
	health = 1.0
	current_game_mode = GameMode.Normal
	current_power_up = PowerUp.Normal
	powerups = []

func _ready() -> void:
	pass
