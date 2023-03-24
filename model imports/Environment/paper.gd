extends Spatial

onready var label = $Viewport/Label

func _ready():
	Singleton.scoreboard = self
	
func show_mistakes():
	label.align = Label.ALIGN_LEFT
	#label.expand_tabs = true
	var tableString = "Padaryta klaidų:\n"
	#for row in Singleton.MistakesArray:
	#	tableString += row[0] + " \t- \t" + str(row[1]) + "\n"
	label.text = tableString
	
func show_score():
	label.align = Label.ALIGN_CENTER
	label.text = "Sveikiname, viskas baigta!\n"
	label.text += "Sudėta kaulų: " + str(Singleton.bones_placed)
	label.text += ".\nJūsų laikas: " + str(round(Singleton.get_time())) + " sek"
	#label.text += ".\nPadaryta klaidų: " + str(Singleton.total_mistakes)
	#label.text += ".\nKiek kartų buvo naudotąsi aukuru: " + str(Singleton.brazier_uses)
	
