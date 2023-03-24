extends Area

export var detect = ""

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.get_name() == detect:
		$model.set_visible(true)
		Singleton.bone_placed(body)
		get_parent().get_node("SuccessSound").play()
		body.queue_free()
		
		#body.id body.mistakes body.brazier_uses body.points
		
		#var sendmessage = "setAnswer(" + body.id + ",true,true,true);"
		#JavaScript.eval(sendmessage)
