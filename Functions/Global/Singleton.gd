extends Node

#there are 29 bones total worth 3 points each
#each mistake removes 1 point, up to 3 per bone (scores kept on bones)
#score is calculated from 0 to 100
#(bone_collected * 3 - num_of_mistakes) x29 maximum is 87
#so it's gonna be that *100/87
#score us updated each event/step
#the fail/pass and complete is only for normal mode
#browsed for browse mode
#To pass you can make 43 mistakes total, or collect 15 bones with no mistakes

onready var scorm = Scorm.new()
var GUI_panel

var bones_placed = 0
var scoreboard
var time = 0.0
var MistakesArray = []
var brazier_uses = 0
var total_mistakes = 0

var tentative_score = 0
var final_score = 0
var mode = ""
var success = "" #status = [passed, failed, unknown]
var status = "" #status = [completed, incomplete, not attempted, browsed]

func _ready():
	add_child(scorm)
	mode = scorm.get_mode() #either normal or browse I think
	for i in range(29):
		MistakesArray.append(["Kaulas", 0])

func bone_placed(points):
	tentative_score += points
	if bones_placed == 1:
		reset_time()
	bones_placed = bones_placed + 1
	calculate_score()
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

func set_status():
	if mode == "browse":
		status = "browsed"
	else:
		match bones_placed:
			0:
				status = "not attempted"
			29:
				status = "completed"
			_:
				status = "incomplete"
	scorm.set_status(status)

func set_success():
	if mode != "browse":
		if final_score >= 50:
			success = "passed"
		else:
			success = "failed"
		scorm.set_success(success)

func calculate_score():
	final_score = tentative_score * 100 / 87
	set_success()
	set_status()
	scorm.set_score(final_score)
	scorm.commit()


