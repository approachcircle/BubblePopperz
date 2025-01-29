extends Node2D

var default_spawn_time = 1.5
var spawn_time = default_spawn_time
# var spawn_time = 0.35
var diff_cap = 0.40
var powerup_activated = false
var bubbles_spawning = true

func _ready() -> void:
	if Globals.current_game_mode != Globals.GameMode.Limitless:
		var health_display: PackedScene = preload("res://scenes/HealthDisplay.tscn")
		self.add_child(health_display.instantiate())
	if Globals.current_game_mode != Globals.GameMode.Powerless:
		var power_up_display: PackedScene = preload("res://scenes/PowerUpDisplay.tscn")
		self.add_child(power_up_display.instantiate())
	start_spawn_bubbles()
	
	
func start_spawn_bubbles():
	bubbles_spawning = true
	while true:
		if not bubbles_spawning:
			break
		if Globals.health <= 0:
			break
		var difficulty: Label = get_node("Difficulty")
		var readable_diff = str(snapped((default_spawn_time - spawn_time) * 1000, 0.1))
		var readable_diff_cap = str(snapped((default_spawn_time - diff_cap) * 1000, 0.1))
		difficulty.text = "Difficulty: " + readable_diff
		if int(readable_diff) >= int(readable_diff_cap):
			difficulty.text = difficulty.text + " (MAX)"
		if Globals.current_game_mode != Globals.GameMode.Powerless:
			roll_power_up()
		var bubble: PackedScene = preload("res://scenes/ExpandingBubble.tscn")
		var bubble_node: Node2D = bubble.instantiate()
		bubble_node.bubble_missed.connect(func lambda(): bubble_missed(bubble_node))
		bubble_node.on_bubble_popped.connect(
			func lambda(type: Globals.PowerUp):
				if not Globals.powerups.has(type):
					Globals.powerups.append(type)
		)
		var vec = Vector2()
		var scr_size = DisplayServer.window_get_size()
		var sidebar: ColorRect = get_node("Sidebar")
		vec.x = randi_range(0, scr_size.x - (sidebar.size.x + 200))
		vec.y = randi_range(0, scr_size.y - 400)
		bubble_node.position = vec
		self.add_child(bubble_node)
		var timer: Timer = Timer.new()
		self.add_child(timer)
		timer.start(spawn_time)
		await timer.timeout
		if spawn_time > diff_cap:
			spawn_time -= 0.03

func roll_power_up():
	for i in Globals.PowerUp.size():
		var upper = 20
		var roll = randi_range(1, upper)
		if roll == upper / 2:
			Globals.current_power_up = Globals.PowerUp.values().pick_random()
			break
		else:
			Globals.current_power_up = Globals.PowerUp.Normal

func bubble_missed(bubble: Node2D):
	var missed: PackedScene = preload("res://scenes/BubbleMissed.tscn")
	var missed_node: Node2D = missed.instantiate()
	missed_node.position = bubble.position
	self.add_child(missed_node)
	bubble.queue_free()
	if Globals.current_game_mode != Globals.GameMode.Limitless:
		Globals.health -= 0.5


func _process(delta: float) -> void:
	for powerup in Globals.active_powerups:
		if powerup_activated:
			break
		if powerup == Globals.PowerUp.Freeze:
			powerup_activated = true
			bubbles_spawning = false
			var children = get_children()
			var paused_bubbles = []
			for child in children:
				var bubble: AnimatedSprite2D = child.get_node_or_null("BubbleExpand")
				if bubble == null:
					continue
				bubble.pause()
				paused_bubbles.append(bubble)
			var timer: Timer = Timer.new()
			timer.one_shot = true
			self.add_child(timer)
			timer.timeout.connect(
				func lambda():
					Globals.active_powerups.clear()
					# cannot use "item in list" pattern as a reference cannot
					# be held to a freed node
					for i in range(0, paused_bubbles.size()):
						if is_instance_valid(paused_bubbles[i]):
							paused_bubbles[i].play()
					powerup_activated = false
					start_spawn_bubbles()
			)
			timer.start(3)
		if powerup == Globals.PowerUp.Nuke:
			powerup_activated = true
			var children = get_children()
			for child in children:
				if child is Bubble:
					child.queue_free()
			var timer: Timer = Timer.new()
			timer.one_shot = true
			self.add_child(timer)
			timer.timeout.connect(
				func lambda():
					Globals.active_powerups.clear()
					powerup_activated = false
			)
			timer.start(1)
