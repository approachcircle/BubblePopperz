extends Control

var thread: Thread
var scene: PackedScene

func _ready() -> void:
	spawn_bubbles()
	var mode_label: Label = get_node("GameMode")
	mode_label.text = "Game mode: " + Globals.GameMode.find_key(Globals.current_game_mode)
	thread = Thread.new()
	var result = thread.start(load_game)
	if result != OK:
		printerr("failed to start thread to load main scene")
		get_tree().quit(1)
	thread.wait_to_finish()
	transfer()

func spawn_bubbles():
	for i in range(0, 10):
		var column: PackedScene = preload("res://scenes/BubbleColumn.tscn")
		var column_node: Node2D = column.instantiate()
		var vec = Vector2()
		var scr_size = DisplayServer.window_get_size()
		#vec.x = randi_range(0, scr_size.x - 100)
		#vec.y = randi_range(0, scr_size.y - 100)
		#vec.x = randi_range(0, 1920 + 200)
		#vec.y = randi_range(-300, 1080)
		vec.x = (i * 200) - 900
		# vec.y = (i * 80) - 400
		vec.y = 300
		vec.y += randi_range(-1, -600)
		
		column_node.position = vec
		column_node.z_index = -i
		column_node.modulate.a = 0.25
		self.add_child(column_node)
	#for i in range(0, 4):
		#var column: PackedScene = preload("res://scenes/BubbleColumn.tscn")
		#var column_node = column.instantiate()
		#var scr_size = DisplayServer.window_get_size()
		#column_node.position

func load_game():
	scene = load("res://scenes/MainScene.tscn")
	
func transfer():
	if scene == null:
		printerr("yeahhh that aint good")
		get_tree().quit(1)
	await get_tree().create_timer(4).timeout
	var result = get_tree().change_scene_to_packed(scene)
	if result != OK:
		printerr("failed to transfer to main scene from loading screen")
		get_tree().quit(1)


func _process(delta: float) -> void:
	pass
