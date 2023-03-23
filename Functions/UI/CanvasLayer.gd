extends CanvasLayer

var bgm
var playback_pos

onready var label = $Label

func _ready():
	bgm = $AudioStreamPlayer
	label.text = "Prisijungė: " + Singleton.learner_name 

func _on_VSlider_value_changed(value):
	if (value == -10):
		bgm.stream_paused = true
	else:
		bgm.volume_db = value*3
		bgm.stream_paused = false
	
