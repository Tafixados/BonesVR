extends Spatial

onready var label = $Viewport/Label
func _ready():
	Singleton.GUI_panel = self
	if Singleton.language == "LT":
		label.text = "Įstatykite kaulus į vietą žmogaus kūne."
	else:
		label.text = "Put the bones into the right place of the human body."
	
func update_label():
	if Singleton.bones_placed >= 29:
		if Singleton.language == "LT":
			label.text = "Sveikiname! Viskas pabaigta! "
		else:
			label.text = "Congratulations! You succeeded!"
		#label.newline()	//richlabeltext method
		JavaScript.eval("setScore();")
	else:
		if Singleton.language == "LT":
			label.text = "Sudėta kaulų: " + str(Singleton.bones_placed) + "/29"
		else:
			label.text = "Bones placed: " + str(Singleton.bones_placed) + "/29"
