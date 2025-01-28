extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bubble = preload("res://scenes/ExpandingBubble.tscn").instantiate()
	bubble.x = DisplayServer.window_get_size().x / 2
	bubble.y = DisplayServer.window_get_size().y / 2
	self.add_child(bubble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
