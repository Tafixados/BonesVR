extends Spatial


onready var label = $Viewport/Label
onready var bone_sprite = $Viewport/Sprite
onready var player = $AnimationPlayer
onready var idle_player = $AnimationPlayer2

var is_open = false
var message_storage
var image_storage

func _ready():
	pass # Replace with function body.

func update_sprite(message, image):
	message_storage = message
	image_storage = image
	if is_open:
		#if message != message_storage:
		player.play("Fade_out")
	else:
		player.play("Open")
		idle_player.play("Open")
		label.text = str(message_storage)
		bone_sprite.texture = load(image_storage)
		


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Open":
			is_open = true
		"Fade_out":
			label.text = str(message_storage)
			bone_sprite.texture = load(image_storage)
			player.play("Fade_in")


func _on_AnimationPlayer2_animation_finished(anim_name):
	match anim_name:
		"Open":
			idle_player.play("Idle")
