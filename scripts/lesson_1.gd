extends Node

var bubbles_spawning = true
var spawn_time = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_spawn_bubbles()
	
func start_spawn_bubbles():
	bubbles_spawning = true
	while true:
		if not bubbles_spawning:
			break
		var bubble: PackedScene = preload("res://scenes/ExpandingBubble.tscn")
		var bubble_node: Node2D = bubble.instantiate()
		bubble_node.bubble_missed.connect(func lambda(): bubble_missed(bubble_node))
		var vec = Vector2()
		var scr_size = DisplayServer.window_get_size()
		vec.x = randi_range(0, scr_size.x - 200)
		vec.y = randi_range(700, scr_size.y - 700)
		bubble_node.position = vec
		self.add_child(bubble_node)
		var timer: Timer = Timer.new()
		self.add_child(timer)
		timer.start(spawn_time)
		await timer.timeout

func bubble_missed(bubble: Node2D):
	var missed: PackedScene = preload("res://scenes/BubbleMissed.tscn")
	var missed_node: Node2D = missed.instantiate()
	missed_node.position = bubble.position
	self.add_child(missed_node)
	bubble.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
