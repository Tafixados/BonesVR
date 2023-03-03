extends CanvasLayer

var bgm
var playback_pos

func _ready():
	bgm = $AudioStreamPlayer

func _on_VSlider_value_changed(value):
	if (value == -10):
		bgm.stream_paused = true
	else:
		bgm.volume_db = value*3
		bgm.stream_paused = false
	
