extends Spatial

onready var label = $Viewport/Label
onready var audio_player = $VictorySound

func _ready():
	Singleton.GUI_panel = self
	
func update_label():
	if Singleton.bones_placed >= Singleton.NumberOfBones:
		label.text = "Sveikiname! Viskas pabaigta!"
		audio_player.volume_db = Singleton.sound_volume
		audio_player.play()
	else:
		label.text = "Sudėta kaulų: " + str(Singleton.bones_placed) + "/" + str(Singleton.NumberOfBones)

