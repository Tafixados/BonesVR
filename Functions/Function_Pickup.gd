extends Area

export var impulse_factor = 10.0
onready var model = $model
var object_in_area = Array()
var picked_up_object = null

var last_position = Vector3(0.0, 0.0, 0.0)
var velocity = Vector3(0.0, 0.0, 0.0)


func _on_Function_Pickup_body_entered(body):
	#add object to array if required
	if (body.has_method('pick_up') or body.has_method('interact')) and object_in_area.find(body) == -1:
		object_in_area.push_back(body)


func _on_Function_Pickup_body_exited(body):
	#remove object from array
	if object_in_area.find(body) != -1:
		object_in_area.erase(body)


# Upper trigger = 0
# Grip trigger = 1
# X/A = 4
# Y/B = 5
func _on_button_pressed(p_button):
	if p_button == 0: #add different mappings for different controllers
		if !object_in_area.empty() && !picked_up_object:
			if object_in_area[0].has_method('pick_up'):
				picked_up_object = object_in_area[0]
				for close_object in object_in_area:
					if close_object.global_transform.origin.distance_to(global_transform.origin) < picked_up_object.global_transform.origin.distance_to(global_transform.origin):
						picked_up_object = close_object
				picked_up_object.pick_up(self)
				model.set_visible(false)
			elif object_in_area[0].has_method('interact'):
				object_in_area[0].interact()
	elif p_button == 1:
		if picked_up_object.has_method('gripped'):
			picked_up_object.gripped()

func _on_button_released(p_button):
	if p_button == 0:
		if picked_up_object:
			#let go of object
			picked_up_object.let_go(velocity * impulse_factor)
			picked_up_object = null
			model.set_visible(true)
			if picked_up_object.has_method('released'):
				picked_up_object.released()
	elif p_button == 1:
		if picked_up_object.has_method('released'):
			picked_up_object.released()
		
func _ready():
	get_parent().connect("button_pressed", self, "_on_button_pressed")
	get_parent().connect("button_release", self, "_on_button_released")
	last_position = global_transform.origin

func _process(delta):
	velocity = global_transform.origin - last_position
	last_position = global_transform.origin
