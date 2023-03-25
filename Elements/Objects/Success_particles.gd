extends Spatial

onready var bones = $Bones
onready var stars = $Stars
onready var audio_player = $SuccessSound

func _ready():
	Singleton.time_to_ruble()
	bones.emitting = true
	stars.emitting = true
	audio_player.volume_db = Singleton.sound_volume
	audio_player.play()

func _on_Timer_timeout():
	queue_free()
