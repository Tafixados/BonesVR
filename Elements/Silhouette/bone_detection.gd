extends Area

export var detect = ""
signal bone_entered

func Connect(body):
	if body.get_name() == detect:
		$model.set_visible(true)
		Singleton.bone_placed(body.points)
		emit_signal("bone_entered")
		get_parent().get_node("SuccessSound").play()
		var sendmessage = "setAnswer(" + body.id + ",true,true,true);"
		JavaScript.eval(sendmessage)

func _on_Skull_body_entered(body):
	Connect(body)

func _on_Mandible_body_entered(body):
	Connect(body)

func _on_Pelvis_body_entered(body):
	Connect(body)

func _on_Spine_body_entered(body):
	Connect(body)
	
func _on_Right_femur_body_entered(body):
	Connect(body)

func _on_Right_ribs_body_entered(body):
	Connect(body)

func _on_Sternum_body_entered(body):
	Connect(body)

func _on_Left_ribs_body_entered(body):
	Connect(body)

func _on_Left_scapula_body_entered(body):
	Connect(body)

func _on_Right_patella_body_entered(body):
	Connect(body)

func _on_Right_foot_body_entered(body):
	Connect(body)

func _on_Right_fibula_body_entered(body):
	Connect(body)

func _on_Right_tibia_body_entered(body):
	Connect(body)

func _on_Right_radius_body_entered(body):
	Connect(body)

func _on_Right_ulna_body_entered(body):
	Connect(body)

func _on_Right_humerus_body_entered(body):
	Connect(body)

func _on_Right_hand_body_entered(body):
	Connect(body)

func _on_Right_scapula_body_entered(body):
	Connect(body)

func _on_Right_clavicle_body_entered(body):
	Connect(body)

func _on_Left_patella_body_entered(body):
	Connect(body)

func _on_Left_foot_body_entered(body):
	Connect(body)

func _on_Left_tibia_body_entered(body):
	Connect(body)

func _on_Left_fibula_body_entered(body):
	Connect(body)

func _on_Left_femur_body_entered(body):
	Connect(body)

func _on_Left_clavicle_body_entered(body):
	Connect(body)

func _on_Left_hand_body_entered(body):
	Connect(body)

func _on_Left_ulna_body_entered(body):
	Connect(body)

func _on_Left_radius_body_entered(body):
	Connect(body)

func _on_Left_humerus_body_entered(body):
	Connect(body)
