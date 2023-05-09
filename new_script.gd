extends Node

#Add SCORM object as child to use SCORM commands
onready var scorm = Scorm.new()

#language settings
var language = "lt"

#Game objects relying on Singleton functions
var scoreboard
signal switch_lang
signal rumble

#Constants
#Max and Min scores for the SCO
const MAXIMUMscore = 100
const MINIMUMscore = 0
#Number of game objects
const NumberOfObjects = 42
#Default points for each object
const MAXOBJECTPOINTS = 3

#Set all variables to 0 or empty for start of game
var objects_placed = 0
var time = 0.0
var total_mistakes = 0
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

func object_placed(body):
	tentative_score += body.points
	total_mistakes += body.mistakes
	objects_placed += 1
	
	scoreboard.get_body(body)
	
	suspendstring = "Viso: " + str(objects_placed) + "/" + str(NumberOfObjects) + "; Klaidų: " + str(total_mistakes) + "; Laikas: " + scorm.convert_time(int(time*1000))
	
	var result = ""
	match (body.points):
		MAXOBJECTPOINTS:
			result = "correct"
		0:
			result = "wrong"
		_:
			result = "neutral"
	
	scorm.set_country(body.id, result, suspendstring)
	
	calculate_score()
	scoreboard.update_label()
	

func _process(delta):
	time += delta

func get_time():
	return time

func reset_all():
	objects_placed = 0
	time = 0.0
	total_mistakes = 0
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
		final_score = clamp((tentative_score * MAXIMUMscore) / (NumberOfObjects * MAXOBJECTPOINTS), MINIMUMscore, MAXIMUMscore)
		#The clamp may be unnecessary, also don't think it works with any minimum score other than 0
		scorm.set_score(final_score)

func change_language(lang):
	language = lang #either "lt" or "en"
	scoreboard.update_label()
	scoreboard.update_panel()
	emit_signal("switch_lang")

func connect_object(object_node):
	connect("switch_lang", object_node, "parse_info")
