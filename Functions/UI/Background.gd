extends Sprite

func _ready():
	set_process(true)  # Enable process callback

func _process(delta):
	var screen_size = get_viewport_rect().size
	set_scale(Vector2(screen_size.x / texture.get_width(), screen_size.y / texture.get_height()))
