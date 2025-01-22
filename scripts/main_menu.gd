extends Control

var covered = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("PlayButton").pressed.connect(slide_cover)
	get_node("Gamemodes/Normal").pressed.connect(func lambda(): transfer_to_load(Globals.GameMode.Normal))
	get_node("Gamemodes/Limitless").pressed.connect(func lambda(): transfer_to_load(Globals.GameMode.Limitless))
	get_node("Gamemodes/Powerless").pressed.connect(func lambda(): transfer_to_load(Globals.GameMode.Powerless))

func slide_cover():
	var animator: AnimationPlayer = get_node("Animator")
	if covered:
		animator.play("uncover")
	else:
		animator.play_backwards("uncover")
	covered = not covered
	
func transfer_to_load(mode: Globals.GameMode):
	Globals.current_game_mode = mode
	var result = get_tree().change_scene_to_file("res://scenes/Loading.tscn")
	if result != OK:
		printerr("failed to transfer to loading screen")
		get_tree().quit(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
