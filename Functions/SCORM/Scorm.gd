extends Node

class_name Scorm

signal score_set(score)

var question_scores = []
var question_times = []

func _ready():
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.connection.initialize()")

func _exit_tree():
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.connection.terminate()")

func set_score(score):
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.SetScoreRaw(" + str(score) + ")")
		emit_signal("score_set", score)

func get_score():
	if Engine.has_singleton("JavaScript"):
		return int(JavaScript.eval("pipwerks.SCORM.GetScoreRaw()"))
	else:
		return 0  # Return a default value when the JavaScript singleton is not available

#status = [completed, incomplete, not attempted, browsed]
func set_status(status):
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.SetCompletionStatus('" + status + "')")

#status = [passed, failed, unknown]
func set_success(status):
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.SetSuccessStatus('" + status + "')")

func commit():
	if Engine.has_singleton("JavaScript"):
		return JavaScript.eval("pipwerks.SCORM.data.save()")

func set_time(time):
	var scorm_time = seconds_to_scorm_time(time)
	if Engine.has_singleton("JavaScript"):
		return JavaScript.eval("pipwerks.SCORM.SetSessionTime('" + scorm_time + "')")
	
func seconds_to_scorm_time(seconds):
	var hours = int(seconds / 3600)
# warning-ignore:integer_division
	var minutes = int((int(seconds) % 3600) / 60)
	var sec = int(seconds) % 60  # Convert the seconds to an integer before applying the modulo operator
	var time_string = "%02d:%02d:%02d" % [hours, minutes, sec]
	return time_string

#mode = [normal, browse]
func get_mode():
	if Engine.has_singleton("JavaScript"):
		return JavaScript.eval("pipwerks.SCORM.GetMode()")

func get_learner_name():
	if Engine.has_singleton("JavaScript"):
		return JavaScript.eval("pipwerks.SCORM.GetLearnerName()")

func set_score_max():
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.SetScoreMax(100)")

func set_score_min():
	if Engine.has_singleton("JavaScript"):
		JavaScript.eval("pipwerks.SCORM.SetScoreMin(0)")

#bone ID, true/false
#correct, wrong, neutral 
func set_bone(number, result, suspendstring):
	if Engine.has_singleton("JavaScript"):
		return JavaScript.eval("pipwerks.SCORM.setBone(" + str(number) + ", '" + result + "', '" + suspendstring + "')")
