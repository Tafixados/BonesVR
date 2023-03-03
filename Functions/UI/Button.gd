extends Button

const HOVER_BRIGHTNESS = 1.2  # The amount to multiply the button's base color when it's being hovered over
var base_color = Color(1, 1, 1)  # The button's base color

func _ready():
	set_process_input(true)  # Enable input processing
	base_color = self.modulate  # Store the button's base color

func _input(event):
	if event is InputEventMouse:
		if is_mouse_hovering():
			self.modulate = base_color * HOVER_BRIGHTNESS  # Set the button's color to its base color multiplied by the hover brightness factor
		else:
			self.modulate = base_color  # Set the button's color back to its base color

func is_mouse_hovering() -> bool:
	var mouse_pos = get_viewport().get_mouse_position()
	var rect = Rect2(Vector2.ZERO, get_size())
	return rect.has_point(mouse_pos)
