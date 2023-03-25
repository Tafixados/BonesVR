extends Spatial

onready var label = $Viewport/Label

func _ready():
	Singleton.scoreboard = self
	update_lang()

func update_lang():
	if (Singleton.language == "lt"):
		label.text = "Jums reikia surinkti pilnus žmogaus griaučius - nuo grindų paimkite ir reikiamoje vietoje įstatykite kaulus į žmogaus kūną.\n\nNaudojantis rankiniu skaitytuvu galite sužinoti kaulo pavadinimą.\n\nĮmetę kaulą į aukurą, apie jį daugiau sužinosite iš magiškojo atlaso."
	else:
		label.text = "Your task is to assemble a complete human skeleton - pick up bones from the floor and place into the correct spots in the human body.\n\nUsing a scanner, you can learn the name of the bone.\n\nBy placing the bone in the brazier, you will learn more about it from the magical atlas."

func show_score():
	if (Singleton.language == "lt"):
		label.text = "Sveikiname, viskas baigta!\n"
		label.text += "Sudėta kaulų: " + str(Singleton.bones_placed)
		label.text += ".\nJūsų laikas: " + Singleton.scorm.convert_time(int(Singleton.time*1000))
		label.text += ".\nPadaryta klaidų: " + str(Singleton.total_mistakes)
		label.text += ".\nKiek kartų buvo naudotąsi aukuru: " + str(Singleton.braziers_used)
		label.text += ".\n\nŠiems rezultatams išsaugoti, išeikite iš VR aplinkos.\nAčiū, kad žaidėte :)"
	else:
		label.text = "Congratulations, everything is complete!\n"
		label.text += "Bones placed: " + str(Singleton.bones_placed)
		label.text += ".\nTime taken: " + Singleton.scorm.convert_time(int(Singleton.time*1000))
		label.text += ".\nMistakes made: " + str(Singleton.total_mistakes)
		label.text += ".\nTimes the brazier was used: " + str(Singleton.braziers_used)
		label.text += ".\n\nTo save these results, exit the immersive VR.\nThank you for playing :)"
	
