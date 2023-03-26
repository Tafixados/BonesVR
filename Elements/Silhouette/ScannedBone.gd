extends StaticBody

var bone_name = "????"
var title = "(????)"
#var description = ""

func _ready():
	pass # Replace with function body.

func this_is_a_bone(body):
	#this is just for scanner detection
	bone_name = body.bone_name
	title = body.title
	#description = body.description
	pass
