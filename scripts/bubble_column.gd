extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bubble: Sprite2D = get_node("Bubble")
	bubble.texture = load("res://assets/frame " + str(RandomNumberGenerator.new().randi_range(0, 4)) + " bubble.png")
	var animator: AnimationPlayer = get_node("Animator")
	if randi_range(0, 1) == 0:
		animator.play("rise")
	else:
		animator.play("rise_alt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
