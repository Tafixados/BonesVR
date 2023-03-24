extends Area

const FlameEffect = preload("res://Elements/Objects/Flame.tscn")
var flameEffect 

onready var Atlas = $Atlas
onready var timer = $Timer
var previous_body

func create_flame_effect():
	flameEffect = FlameEffect.instance()
	add_child(flameEffect)
	flameEffect.global_transform.origin = global_transform.origin
	timer.start(2)
	


func _on_Area_body_entered(body):
	if body.has_method('out_of_bounds'):
		if previous_body != body:
			body.brazier_uses += 1
			create_flame_effect()
			var message = str(body.bone_name) + " " + str(body.title) + " - " + str(body.description)
			Atlas.update_sprite(message, body.image)
			previous_body = body


func _on_Timer_timeout():
	flameEffect.queue_free()
