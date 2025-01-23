extends Node2D

var health: Sprite2D
var heartbraking = false

func _ready() -> void:
	# hopefully this runs before process?
	health = get_node("Health")



func _process(delta: float) -> void:
	var health: Sprite2D = get_node("Health")
	#match Globals.health:
		#1.0:
			#health.texture = load("res://assets/Heart.png")
		#0.5:
			#health.texture = load("res://assets/halfheart.png")
		#0:
			#health.texture = load("res://assets/Noheart.png")
			#heartbroken()
	if Globals.health == 1.0:
		health.texture = load("res://assets/Heart.png")
	elif Globals.health == 0.5:
		health.texture = load("res://assets/halfheart.png")
	else:
		if heartbraking:
			return
		health.texture = load("res://assets/Noheart.png")
		heartbroken()

func heartbroken():
	heartbraking = true
	var animator: AnimationPlayer = get_node("Animator")
	animator.play("center")
	await animator.animation_finished
	animator.play("shake")
	await animator.animation_finished
	var timer: Timer = Timer.new()
	self.add_child(timer)
	timer.start(1)
	await timer.timeout
	health.texture = load("res://assets/heartbreak.png")
	timer.start(2)
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
