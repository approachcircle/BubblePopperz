extends Node2D

var default_spawn_time = 1.5
var spawn_time = default_spawn_time
var diff_cap = 0.3

func _ready() -> void:
	if Globals.current_game_mode != Globals.GameMode.Limitless:
		var health_display: PackedScene = preload("res://scenes/HealthDisplay.tscn")
		self.add_child(health_display.instantiate())
	start_spawn_bubbles()
	
func start_spawn_bubbles():
	while true:
		if Globals.health <= 0:
			break
		var difficulty: Label = get_node("Difficulty")
		var readable_diff = str((default_spawn_time - spawn_time) * 1000)
		difficulty.text = "Difficulty: " + str(snapped((default_spawn_time - spawn_time) * 1000, 0.1))
		if str(snapped((default_spawn_time - spawn_time) * 1000, 0.1)) == str(snapped((default_spawn_time - diff_cap) * 1000, 0.1)):
			difficulty.text = difficulty.text + " (MAX)"
		var bubble: PackedScene = preload("res://scenes/ExpandingBubble.tscn")
		var bubble_node: Node2D = bubble.instantiate()
		bubble_node.bubble_missed.connect(func lambda(): bubble_missed(bubble_node))
		var vec = Vector2()
		var scr_size = DisplayServer.window_get_size()
		vec.x = randi_range(0, scr_size.x - 200)
		vec.y = randi_range(0, scr_size.y - 200)
		bubble_node.position = vec
		self.add_child(bubble_node)
		var timer: Timer = Timer.new()
		self.add_child(timer)
		timer.start(spawn_time)
		await timer.timeout
		if spawn_time > diff_cap:
			spawn_time -= 0.01
		
func bubble_missed(bubble: Node2D):
	var missed: PackedScene = preload("res://scenes/BubbleMissed.tscn")
	var missed_node: Node2D = missed.instantiate()
	missed_node.position = bubble.position
	self.add_child(missed_node)
	bubble.queue_free()
	if Globals.current_game_mode != Globals.GameMode.Limitless:
		Globals.health -= 0.5


func _process(delta: float) -> void:
	pass
