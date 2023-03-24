extends HBoxContainer

var playback_pos

onready var player = $AnimationPlayer
onready var bgm = $AudioStreamPlayer
var infoshown = false

var current_bgm = 0

var bgm1 = preload("res://assets/audio/bgm1.ogg")
var bgm2 = preload("res://assets/audio/bgm2.ogg")
var bgm3 = preload("res://assets/audio/bgm3.ogg")

var bgmarray = [bgm1, bgm2, bgm3]

func _ready():
	bgm.stream = bgmarray[current_bgm]
	bgm.play()

func _on_InfoButton_pressed():
	if (!infoshown):
		player.play("ShowInfo")
	else:
		player.play("ShowSkele")
	infoshown = !infoshown

func _on_AudioSlider_value_changed(value):
	if (value == -10):
		bgm.stream_paused = true
	else:
		bgm.volume_db = value*3
		bgm.stream_paused = false


func _on_Previous_pressed():
	current_bgm -=1
	if current_bgm < 0:
		current_bgm = bgmarray.size() - 1
	bgm.stream = bgmarray[current_bgm]
	bgm.play()


func _on_Next_pressed():
	current_bgm +=1
	if current_bgm + 1> bgmarray.size():
		current_bgm = 0
	bgm.stream = bgmarray[current_bgm]
	bgm.play()


func _on_InfoButton_mouse_entered():
	if (!infoshown):
		player.play("ShowInfo")
	else:
		player.play("ShowSkele")
	infoshown = !infoshown
