extends Spatial

onready var label = $Viewport/Label

func _ready():
	Singleton.scoreboard = self
	if Singleton.language == "LT":
		label.text = "Jums reikia surinkti pilnus žmogaus griaučius - nuo grindų paimkite ir reikiamoje vietoje įstatykite kaulus į žmogaus kūną.\n\n"
		label.text += "Naudojantis rankiniu skaitytuvu galite sužinoti kaulo pavadinimą.\n\n"
		label.text += "Įmetę kaulą į aukurą, apie jį daugiau sužinosite iš magiškojo atlaso."
	else:
		label.text = "You need to collect a complete human skeleton - pick up the bones from the floor and insert them into the human body at the right place.\n\n"
		label.text += "Use a hand-held scanner to find out the name of the bone.\n\n"
		label.text += "Once you have placed the bone on the altar, you can learn more about it from the magic atlas."
	
func show_score():
	if Singleton.language == "LT":
		label.text = "Sveikiname, viskas baigta!\n"
		label.text += "Sudėta kaulų: " + str(Singleton.bones_placed)
		label.text += ".\nJūsų laikas: " + str(round(Singleton.get_time())) + " sek"
		label.text += ".\nPadaryta klaidų: " + str(Singleton.mistakes)
		label.text += ".\nKiek kartų buvo naudotąsi aukuru: " + str(Singleton.brazier_uses)
	else:
		label.text = "Congratulations, it's done!\n"
		label.text += "Placed bones: " + str(Singleton.bones_placed)
		label.text += ".\nYour time: " + str(round(Singleton.get_time())) + " sec."
		label.text += ".\nMistakes: " + str(Singleton.mistakes)
		label.text += ".\nThe brazier has been used " + str(Singleton.brazier_uses) + " times."
