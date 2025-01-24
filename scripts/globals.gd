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
var powerups: Array[PowerUp] = []
var active_powerups: Array[PowerUp] = []
var health = 1.0
var hits_with_shield = 0

func load_defaults():
	health = 1.0
	current_game_mode = GameMode.Normal
	current_power_up = PowerUp.Normal
	powerups = []
	active_powerups = []
	hits_with_shield = 0

func _ready() -> void:
	pass
