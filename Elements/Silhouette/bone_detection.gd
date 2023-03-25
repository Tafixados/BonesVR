extends Area

const partices_sound = preload("res://Elements/Objects/Success_particles.tscn")
var effect
export var detect = ""

func _ready():
	connect("body_entered", self, "_on_body_entered")

func create_effect():
	effect = partices_sound.instance()
	add_child(effect)
	effect.global_transform.origin = global_transform.origin

func _on_body_entered(body):
	if body.get_name() == detect:
		$model.set_visible(true)
		Singleton.bone_placed(body)
		create_effect()
		body.queue_free()
		
		#body.id body.mistakes body.brazier_uses body.points
		
		#var sendmessage = "setAnswer(" + body.id + ",true,true,true);"
		#JavaScript.eval(sendmessage)
