extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Next").pressed.connect(
		func lambda():
			if get_node("Next").text == "End":
				get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
			else:
				Globals.current_lesson += 1
				# if the transfer fails, revert our lesson number back
				if transfer_to_new_lesson() == null:
					Globals.current_lesson -= 1
	)
	get_node("Back").pressed.connect(
		func lambda():
			Globals.current_lesson -= 1
			if Globals.current_lesson == 0:
				get_tree().change_scene_to_packed(load("res://scenes/Lessons/Intro.tscn"))
			else:
				if transfer_to_new_lesson() == null:
					Globals.current_lesson += 1
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_node("Back").visible = Globals.current_lesson != 0
	if Globals.current_lesson == Globals.total_lessons - 1:
		get_node("Next").text = "End"
	else:
		get_node("Next").text = "Next"

func transfer_to_new_lesson() -> Resource:
	var new_lesson = load("res://scenes/Lessons/Lesson" + str(Globals.current_lesson) + ".tscn")
	get_tree().change_scene_to_packed(new_lesson)
	return new_lesson
