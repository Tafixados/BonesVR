extends Spatial

onready var label = $Viewport/Label
onready var audio_player = $VictorySound

func _ready():
	Singleton.GUI_panel = self
	
func update_lang():
	if (Singleton.language == "lt"):
		label.text = "Užduotis: Įstatykite kaulus į vietą žmogaus kūne."
	else:
		label.text = "Place the bones on the ground into the human body."
	
	
func update_label():
	if (Singleton.language == "lt"):
		if Singleton.bones_placed >= Singleton.NumberOfBones:
			label.text = "Sveikiname! Viskas pabaigta!"
			audio_player.volume_db = Singleton.sound_volume
			audio_player.play()
		else:
			label.text = "Sudėta kaulų: " + str(Singleton.bones_placed) + "/" + str(Singleton.NumberOfBones)
	else:
		if Singleton.bones_placed >= Singleton.NumberOfBones:
			label.text = "Congratulations! Everything's finished!"
			audio_player.volume_db = Singleton.sound_volume
			audio_player.play()
		else:
			label.text = "Bones placed: " + str(Singleton.bones_placed) + "/" + str(Singleton.NumberOfBones)
