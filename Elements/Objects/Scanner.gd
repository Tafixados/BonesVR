extends RigidBody

#Scanner collision mask = 13
#Remember the state so we can return it when the player drops the object
onready var original_parent = get_parent()
onready var raycast = $RayCast
onready var raycast_sprite = $RayCast/RaycastSprite
onready var label = $Viewport/Label
var original_collision_mask
var original_collision_layer
var original_global_position
var timer

var is_gripped = false
#Who picked us up?
var picked_up_by = null

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
	#collision_layer = 0
	#collision_mask = 0
	if (Singleton.language == "lt"):
		label.text = "Nuspauskite gaiduką, kad skenuoti kaulą"
	else:
		label.text = "Pull the trigger to scan a bone"
	
	#Reparent
	original_parent.remove_child(self)
	picked_up_by.add_child(self)
	get_parent().connect("button_pressed", self, "_on_button_pressed")
	get_parent().connect("button_release", self, "_on_button_released")
	
	#Reset our transform
	transform = Transform()

#Letting go
func let_go(impulse = Vector3(0.0, 0.0, 0.0)):
	if picked_up_by:
		#Get current global transform
		var t = global_transform
		
		#Reparent
		picked_up_by.get_node("model").set_visible(true)
		picked_up_by.remove_child(self)
		original_parent.add_child(self)
		
		#Reposition and apply impulse
		global_transform = t
		mode = RigidBody.MODE_RIGID
		set_timer()
		#collision_mask = original_collision_mask
		#collision_layer = original_collision_layer
		apply_impulse(Vector3(0.0, 0.0, 0.0), impulse)
		
		#No longer picked up
		picked_up_by = null
		
		#ungrip just in case
		is_gripped = false
		raycast_sprite.set_visible(false)
		label.text = ""

func _ready():
	original_collision_mask = collision_mask
	original_collision_layer = collision_layer
	original_global_position = global_transform.origin

func gripped():
	raycast_sprite.set_visible(true)
	is_gripped = true

func released():
	is_gripped = false
	raycast_sprite.set_visible(false)
	label.text = ""

func set_timer():
	timer = Timer.new()
	timer.wait_time = 3
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	timer.one_shot = true
	timer.connect("timeout",self,"turn_static")
	add_child(timer)
	timer.start()

func turn_static():
	mode = RigidBody.MODE_STATIC
	timer.queue_free()

func _process(delta):
	if is_gripped:
		if raycast.is_colliding():
			var scanned_object = raycast.get_collider()
			if scanned_object.has_method('this_is_a_bone'):
				label.text = str(scanned_object.bone_name) + " " + str(scanned_object.title)
				scanned_object.change_color()
				#stretch_sprite_to_scanned_object(scanned_object)
		else:
			#reset_stretch()
			if (Singleton.language == "lt"):
				label.text = "Nieko nerasta."
			else:
				label.text = "Nothing found."

#func stretch_sprite_to_scanned_object(scanned_object):
	# Calculate the distance between the RayCast and the scanned_object
	#var distance = raycast.global_transform.origin.distance_to(scanned_object.global_transform.origin)
	# Scale the Sprite3D in the X axis according to the calculated distance
	#raycast_sprite.scale.x = distance
	# Update the Sprite3D's position to be in the middle between the RayCast and the scanned_object
	#raycast_sprite.global_transform.origin = raycast.global_transform.origin.linear_interpolate(scanned_object.global_transform.origin, 0.5)
	
#func reset_stretch():
	#raycast_sprite.scale.x = 1
	#raycast_sprite.global_transform.origin = Vector3(0,0,0)
