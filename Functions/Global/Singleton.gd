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

var total_mistakes = 0
var braziers_used = 0

var tentative_score = 0
var final_score = 0

var mode = "" 
var success = "" #status = [passed, failed, unknown]
var status = "" #status = [completed, incomplete, not attempted, browsed]

var learner_name = ""
var suspendstring

func _ready():
	add_child(scorm)
	mode = scorm.get_mode() #either normal or browse I think
	learner_name = scorm.get_learner_name()
	#scorm.set_score_max()
	#scorm.set_score_min()

func bone_placed(body):
	tentative_score += body.points
	total_mistakes += body.mistakes
	braziers_used += body.brazier_uses
	bones_placed += 1
	
	suspendstring = "Viso: " + str(bones_placed) + "/29; Klaidų: " + str(total_mistakes) + "; Pagalbos: " + str(braziers_used) + "; Laikas: " + scorm.seconds_to_scorm_time(time)
	
	var result = ""
	match (body.points):
		3:
			result = "correct"
		0:
			result = "wrong"
		_:
			result = "neutral"
	
	scorm.set_bone(body.id, result, suspendstring)
	
	calculate_score()
	GUI_panel.update_label()
	if bones_placed >= 29:
		scoreboard.show_score()
		scorm.commit()

func _process(delta):
	time += delta

func get_time():
	return time

func reset_all():
	bones_placed = 0
	time = 0.0
	total_mistakes = 0
	braziers_used = 0
	tentative_score = 0
	final_score = 0

func set_status():
	if mode == "browse":
		status = "browsed"
	else:
		status = "completed"
	scorm.set_status(status)

func set_success():
	if mode != "browse":
		if final_score >= 50:
			success = "passed"
		else:
			success = "failed"
		scorm.set_success(success)

func calculate_score():
	set_success()
	set_status()
	if mode != "browse":
		final_score = clamp(tentative_score * 100 / 87, 0, 100)
		scorm.set_score(final_score)


