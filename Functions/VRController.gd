extends ARVRController

onready var timer = $Timer

func _ready():
	Singleton.connect_controller(self)

func time_to_rumble():
	rumble = 1.0
	timer.wait_time = 0.2
	
func _on_Timer_timeout():
	rumble = 0.0

