extends Node2D

var spawn_time = 2

func _ready() -> void:
	start_spawn_bubbles()
	
func start_spawn_bubbles():
	while true:
		var bubble: PackedScene = preload("res://scenes/ExpandingBubble.tscn")
		var bubble_node: Node2D = bubble.instantiate()
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
		spawn_time -= 0.1


func _process(delta: float) -> void:
	pass
