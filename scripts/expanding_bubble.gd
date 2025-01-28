extends Node2D
class_name Bubble

var bubble: AnimatedSprite2D
var type: Globals.PowerUp
signal bubble_missed
signal on_bubble_popped(bubble_type: Globals.PowerUp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble = get_node("BubbleExpand")
	var clickable: Button = get_node("Clickable")
	clickable.pressed.connect(bubble_popped)
	clickable.modulate.a = 0
	var pop: AnimatedSprite2D = get_node("BubblePop")
	pop.modulate.a = 0
	assert(Globals.current_power_up != null)
	print("current set powerup: " + str(Globals.PowerUp.find_key(Globals.current_power_up)))
	match Globals.current_power_up:
		Globals.PowerUp.Normal:
			bubble.play("base")
		Globals.PowerUp.Shield:
			bubble.play("shield")
		Globals.PowerUp.Nuke:
			bubble.play("nuke")
		Globals.PowerUp.Freeze:
			bubble.play("freeze")
		_:
			bubble.play("base")
	type = Globals.current_power_up
	bubble.animation_finished.connect(bubble_missed.emit)

func bubble_popped():
	bubble.modulate.a = 0
	bubble.stop()
	var pop: AnimatedSprite2D = get_node("BubblePop")
	pop.modulate.a = 1
	pop.play("pop")
	await pop.animation_finished
	self.queue_free()
	on_bubble_popped.emit(type)
	
func _process(delta: float) -> void:
	pass
