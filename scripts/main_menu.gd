extends Control

var covered = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("PlayButton").pressed.connect(slide_cover)

func slide_cover():
	var animator: AnimationPlayer = get_node("Animator")
	if covered:
		animator.play("uncover")
	else:
		animator.play_backwards("uncover")
	covered = not covered

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
