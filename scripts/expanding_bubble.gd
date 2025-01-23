extends Node2D

var bubble: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble = get_node("BubbleExpand")
	var clickable: Button = get_node("Clickable")
	clickable.pressed.connect(bubble_popped)
	clickable.modulate.a = 0
	var pop: AnimatedSprite2D = get_node("BubblePop")
	pop.modulate.a = 0
	bubble.play("expand")

func bubble_popped():
	bubble.modulate.a = 0
	var pop: AnimatedSprite2D = get_node("BubblePop")
	pop.modulate.a = 1
	pop.play("pop")
	await pop.animation_finished
	self.queue_free()
	
func _process(delta: float) -> void:
	pass
