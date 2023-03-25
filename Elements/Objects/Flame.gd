extends Spatial

onready var player = $AudioStreamPlayer

func _ready():
	player.volume_db = Singleton.sound_volume
	player.play()
