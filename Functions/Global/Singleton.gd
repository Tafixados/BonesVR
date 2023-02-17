extends Node

var bones_placed = 0
var GUI_panel
var scoreboard
var time = 0.0
var mistakes = 0
var brazier_uses = 0
var language = "LT"

func bone_placed():
	if bones_placed == 1:
		reset_time()
	bones_placed = bones_placed + 1
	GUI_panel.update_label()
	if bones_placed >= 29:
		scoreboard.show_score()

func _process(delta):
	time += delta

func get_time():
	return time

func reset_time():
	time = 0.0

func reset_all():
	bones_placed = 0
	time = 0.0
	mistakes = 0
	brazier_uses = 0
