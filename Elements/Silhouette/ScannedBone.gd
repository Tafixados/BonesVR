extends StaticBody

onready var material = $model/mesh.get_active_material(0)
onready var color_timer = $Timer

var bone_name = "????"
var title = "(????)"
#var description = ""

func _ready():
	color_timer.connect("timeout",self,"return_colour")
	pass # Replace with function body.

func this_is_a_bone(body):
	#this is just for scanner detection
	bone_name = body.bone_name
	title = body.title
	#description = body.description
	pass

func change_color():
	material.albedo_color = Color(0, 0.5, 1, 1)
	#material.roughness = 0.0
	color_timer.wait_time = 0.1
	color_timer.start()

func return_colour():
	material.albedo_color = Color(1, 1, 1, 1)
	#material.roughness = 0.91
