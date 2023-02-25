extends Node

var bones_placed = 0
var GUI_panel
var scoreboard
var time = 0.0
var MistakesArray = []
var brazier_uses = 0
var total_mistakes = 0

func _ready():
	for i in range(29):
		MistakesArray.append(["Kaulas", 0])

func bone_placed():
	if bones_placed == 1:
		reset_time()
	bones_placed = bones_placed + 1
	GUI_panel.update_label()
	if bones_placed >= 29:
		calculate_mistakes()
		scoreboard.show_score()
	else:
		update_mistakes()

func calculate_mistakes():
	for row in MistakesArray:
		total_mistakes += row[1]

func update_mistakes():
	scoreboard.show_mistakes()

func _process(delta):
	time += delta

func get_time():
	return time

func reset_time():
	time = 0.0

func reset_all():
	bones_placed = 0
	reset_time()
	for row in MistakesArray:
		row[1] = 0
	brazier_uses = 0
