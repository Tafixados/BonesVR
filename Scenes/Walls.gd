extends Area

func _on_Walls_body_entered(body):
	if body.has_method('out_of_bounds'):
		body.out_of_bounds()
		Singleton.mistakes += 1
		var sendmessage = "setAnswer(" + body.id + ",true,false,false);"
		JavaScript.eval(sendmessage)
