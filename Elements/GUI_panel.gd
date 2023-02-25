extends Spatial

onready var label = $Viewport/Label
func _ready():
	Singleton.GUI_panel = self
	
func update_label():
	if Singleton.bones_placed >= 29:
		label.text = "Sveikiname! Viskas pabaigta! "
		#label.newline()	//richlabeltext method
		JavaScript.eval("setScore();")
	else:
		label.text = "Sudėta kaulų: " + str(Singleton.bones_placed) + "/29"

