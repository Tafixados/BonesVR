extends CanvasLayer

onready var label = $MarginContainer/VBoxContainer/LoginName

func _ready():
	set_process(true)  # Enable process callback
	label.text = "Prisijungė: " + Singleton.learner_name 

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size

	# Scale ColorRect
	$ColorRect.rect_min_size = screen_size

	# Scale MarginContainer and its children
	$MarginContainer.rect_min_size = screen_size
	$MarginContainer.rect_scale = Vector2(screen_size.x / $MarginContainer.rect_size.x, screen_size.y / $MarginContainer.rect_size.y)
