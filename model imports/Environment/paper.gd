extends Spatial

onready var label = $Viewport/Label

func _ready():
	Singleton.scoreboard = self
	
func show_score():
	label.text = "Sveikiname, viskas baigta!\n"
	label.text += "Sudėta kaulų: " + str(Singleton.bones_placed)
	label.text += ".\nJūsų laikas: " + str(round(Singleton.get_time())) + " sek"
	label.text += ".\nPadaryta klaidų: " + str(Singleton.mistakes)
	label.text += ".\nKiek kartų buvo naudotąsi aukuru: " + str(Singleton.brazier_uses)
	
