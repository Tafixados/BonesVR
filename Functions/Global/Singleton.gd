extends Node

#Add SCORM object as child to use SCORM commands
onready var scorm = Scorm.new()

#language settings
var language = "lt"

#Game objects relying on Singleton functions
var GUI_panel
var scoreboard
signal switch_lang
signal rumble


#Constants
#Max and Min scores for the SCO
const MAXIMUMscore = 100
const MINIMUMscore = 0
#Number of game objects
const NumberOfBones = 29
#Default points for each object
const MAXBONEPOINTS = 3

#Set all variables to 0 or empty for start of game
var bones_placed = 0
var time = 0.0
var total_mistakes = 0
var braziers_used = 0
var tentative_score = 0
var final_score = 0
var sound_volume = 0

var mode = ""  #mode - [browse, normal, review] (read only)
var success = "" #status = [passed, failed, unknown] (read write)
var status = "" #status = [completed, incomplete, not attempted, browsed] (idk documentation is bad)
var learner_name = "" #student name we get from the LMS
var suspendstring = "" #bonus content data we send (only one entry per session tho, so make it count)

func _ready():
	add_child(scorm)
	mode = scorm.get_mode() #either normal or browse I think
	learner_name = scorm.get_learner_name() #Surname, Name
	scorm.set_score_max(MAXIMUMscore) 
	scorm.set_score_min(MINIMUMscore)

func bone_placed(body):
	tentative_score += body.points
	total_mistakes += body.mistakes
	braziers_used += body.brazier_uses
	bones_placed += 1
	
	suspendstring = "Viso: " + str(bones_placed) + "/" + str(NumberOfBones) + "; Klaidų: " + str(total_mistakes) + "; Pagalbos: " + str(braziers_used) + "; Laikas: " + scorm.convert_time(int(time*1000))
	
	var result = ""
	match (body.points):
		MAXBONEPOINTS:
			result = "correct"
		0:
			result = "wrong"
		_:
			result = "neutral"
	
	scorm.set_bone(body.id, result, suspendstring)
	
	calculate_score()
	GUI_panel.update_label()
	if bones_placed >= NumberOfBones:
		scoreboard.show_score()
		#scorm.commit()

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
	scorm.set_time(int(time*1000))
	if mode != "browse":
		final_score = clamp((tentative_score * MAXIMUMscore) / (NumberOfBones * MAXBONEPOINTS), MINIMUMscore, MAXIMUMscore)
		#The clamp may be unnecessary, also don't think it works with any minimum score other than 0
		scorm.set_score(final_score)

func time_to_ruble():
	emit_signal("rumble")

func change_language(lang):
	language = lang #either "lt" or "en"
	scoreboard.update_lang()
	GUI_panel.update_lang()
	emit_signal("switch_lang")

func connect_controller(controller_node):
	connect("rumble", controller_node, "time_to_rumble")

func connect_bone(bone_node):
	connect("switch_lang", bone_node, "parse_info")
