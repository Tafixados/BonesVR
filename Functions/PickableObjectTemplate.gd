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
var bone_name = "Kaulas"
var title = "(lot. ossa)"
var description = "Paskirtis"
var image = ""
var points
var mistakes = 0
var brazier_uses = 0

#var model

func _ready():
	points = Singleton.MAXBONEPOINTS #Set the points to 3
	parse_info()
	Singleton.connect_bone(self)
	
	original_collision_mask = collision_mask
	original_collision_layer = collision_layer
	original_global_position = global_transform.origin
	set_timer()

func parse_info():
	if Singleton.language == "lt":
		bone_name = BoneInfo.get_value_lt(str(id), "Name")
		title = BoneInfo.get_value_lt(str(id), "Title")
		description = BoneInfo.get_value_lt(str(id), "Description")
		image = BoneInfo.get_value_lt(str(id), "Image")
	else:
		bone_name = BoneInfo.get_value_en(str(id), "Name")
		title = BoneInfo.get_value_en(str(id), "Title")
		description = BoneInfo.get_value_en(str(id), "Description")
		image = BoneInfo.get_value_en(str(id), "Image")

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


# Since the game can't handle constantly simulating tons of rigidbodies
# we revert it to a static body after a few seconds of being let go.
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
