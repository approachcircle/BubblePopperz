extends Node

var shield_button: Button
var nuke_button: Button
var freeze_button: Button

func _ready() -> void:
	get_node("BigShield").visible = false
	shield_button = get_node("ShieldButton")
	nuke_button = get_node("NukeButton")
	freeze_button = get_node("FreezeButton")
	shield_button.modulate.a = 0
	nuke_button.modulate.a = 0
	freeze_button.modulate.a = 0
	# shield_button.pressed.connect(shield_used)
	freeze_button.pressed.connect(freeze_used)
	nuke_button.pressed.connect(nuke_used)

func shield_used():
	if Globals.active_powerups.size() > 0:
		return
	if Globals.PowerUp.Shield not in Globals.powerups:
		return
	Globals.active_powerups.append(Globals.PowerUp.Shield)
	var animator: AnimationPlayer = get_node("Animator")
	animator.play("use_shield")
	await animator.animation_finished
	Globals.powerups.remove_at(Globals.powerups.rfind(Globals.PowerUp.Shield))

func freeze_used():
	if Globals.active_powerups.size() > 0:
		return
	if Globals.PowerUp.Freeze not in Globals.powerups:
		return
	Globals.active_powerups.append(Globals.PowerUp.Freeze)
	var animator: AnimationPlayer = get_node("Animator")
	animator.play("use_freeze")
	await animator.animation_finished
	Globals.powerups.remove_at(Globals.powerups.rfind(Globals.PowerUp.Freeze))
	
func nuke_used():
	if Globals.active_powerups.size() > 0:
		return
	if Globals.PowerUp.Nuke not in Globals.powerups:
		return
	Globals.active_powerups.append(Globals.PowerUp.Nuke)
	# var animator: AnimationPlayer = get_node("Animator")
	# animator.play("use_nuke")
	# await animator.animation_finished
	Globals.powerups.remove_at(Globals.powerups.rfind(Globals.PowerUp.Nuke))

func _process(delta: float) -> void:
	# get_node("Shield").visible = Globals.PowerUp.Shield in Globals.powerups
	get_node("Nuke").visible = Globals.PowerUp.Nuke in Globals.powerups
	get_node("Freeze").visible = Globals.PowerUp.Freeze in Globals.powerups
	# get_node("BigShield").visible = Globals.PowerUp.Shield in Globals.active_powerups
	get_node("BigFreeze").visible = Globals.PowerUp.Freeze in Globals.active_powerups
	if Input.is_action_just_pressed("use_shield"):
		shield_button.emit_signal("pressed")
	if Input.is_action_just_pressed("use_freeze"):
		freeze_button.emit_signal("pressed")
	if Input.is_action_just_pressed("use_nuke"):
		nuke_button.emit_signal("pressed")
