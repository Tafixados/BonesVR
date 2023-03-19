extends RigidBody

#Remember the state so we can return it when the player drops the object
onready var original_parent = get_parent()
var original_collision_mask
var original_collision_layer
var original_global_position
var timer

#Who picked us up?
var picked_up_by = null

#Description for brazier
export var id = 0
export var bone_name = "Kaulas"
export var title = "Kaulas (lot. ossa)"
export var description = "Paskirtis"
export var image = ""
export var points = 3

#Being picked up
func pick_up(by):
	if picked_up_by == by:
		return
	
	if picked_up_by:
		let_go()
	
	#Remembering who picked us up
	picked_up_by = by
	
	#Turn off the physics of our pickable object
	mode = RigidBody.MODE_STATIC
	collision_layer = 2
	collision_mask = 0
	
	#Reparent
	original_parent.remove_child(self)
	picked_up_by.add_child(self)
	
	#Reset our transform
	transform = Transform()

#Letting go
func let_go(impulse = Vector3(0.0, 0.0, 0.0)):
	if picked_up_by:
		#Get current global transform
		var t = global_transform
		
		#Reparent
		picked_up_by.remove_child(self)
		original_parent.add_child(self)
		
		#Reposition and apply impulse
		global_transform = t
		mode = RigidBody.MODE_RIGID
		collision_mask = original_collision_mask
		collision_layer = original_collision_layer
		apply_impulse(Vector3(0.0, 0.0, 0.0), impulse)
		set_timer()
		#No longer picked up
		picked_up_by = null

func _ready():
	original_collision_mask = collision_mask
	original_collision_layer = collision_layer
	original_global_position = global_transform.origin
	set_timer()
	Singleton.MistakesArray[id-1][0] = bone_name

func set_timer():
	timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = true
	timer.connect("timeout",self,"turn_static")
	add_child(timer)
	timer.start()

func turn_static():
	mode = RigidBody.MODE_STATIC
	timer.queue_free()

func out_of_bounds():
	global_transform.origin = original_global_position
	if points > 0:
		points -= 1
	

func _on_Skull_bone_entered():
	queue_free()

func _on_Mandible_bone_entered():
	queue_free()

func _on_Pelvis_bone_entered():
	queue_free()

func _on_Spine_bone_entered():
	queue_free()

func _on_Right_femur_bone_entered():
	queue_free()

func _on_Right_ribs_bone_entered():
	queue_free()

func _on_Sternum_bone_entered():
	queue_free()

func _on_Left_ribs_bone_entered():
	queue_free()

func _on_Left_scapula_bone_entered():
	queue_free()

func _on_Left_humerus_bone_entered():
	queue_free()

func _on_Left_radius_bone_entered():
	queue_free()

func _on_Left_ulna_bone_entered():
	queue_free()

func _on_Left_hand_bone_entered():
	queue_free()

func _on_Left_clavicle_bone_entered():
	queue_free()

func _on_Left_femur_bone_entered():
	queue_free()

func _on_Left_fibula_bone_entered():
	queue_free()

func _on_Left_tibia_bone_entered():
	queue_free()

func _on_Left_foot_bone_entered():
	queue_free()

func _on_Left_patella_bone_entered():
	queue_free()

func _on_Right_clavicle_bone_entered():
	queue_free()

func _on_Right_scapula_bone_entered():
	queue_free()

func _on_Right_hand_bone_entered():
	queue_free()

func _on_Right_humerus_bone_entered():
	queue_free()

func _on_Right_ulna_bone_entered():
	queue_free()

func _on_Right_radius_bone_entered():
	queue_free()

func _on_Right_tibia_bone_entered():
	queue_free()

func _on_Right_fibula_bone_entered():
	queue_free()

func _on_Right_foot_bone_entered():
	queue_free()

func _on_Right_patella_bone_entered():
	queue_free()
