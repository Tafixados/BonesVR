extends StaticBody

var active = false
onready var anim = $AnimationPlayer
onready var audio = $AudioStreamPlayer

func interact():
	
	if (active):
		Singleton.reset_all()
		#get_scene_root()._exit_vr()
		#get_viewport().arvr = false
		get_tree().reload_current_scene()
		#$"../../CanvasLayer".visible = false
	else:
		anim.play("OpenLatch")
		audio.volume_db = Singleton.sound_volume
		audio.play()

func get_scene_root() -> Node:
	var current_node = self
	while current_node.get_parent():
		current_node = current_node.get_parent()
	return current_node


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "OpenLatch":
		active = !active
