extends Spatial

onready var label = $Viewport/Label

func _ready():
	Singleton.scoreboard = self
	

func show_score():
	label.align = Label.ALIGN_CENTER
	label.text = "Sveikiname, viskas baigta!\n"
	label.text += "Sudėta kaulų: " + str(Singleton.bones_placed)
	label.text += ".\nJūsų laikas: " + Singleton.scorm.convert_time(int(Singleton.time*1000))
	label.text += ".\nPadaryta klaidų: " + str(Singleton.total_mistakes)
	label.text += ".\nKiek kartų buvo naudotąsi aukuru: " + str(Singleton.braziers_used)
	label.text += ".\n\nŠiems rezultatams išsaugoti, išeikite iš VR aplinkos.\nAčiū, kad žaidėte :)"
	
