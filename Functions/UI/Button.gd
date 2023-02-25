extends Button

const HOVER_BRIGHTNESS = 1.2  # The amount to multiply the button's base color when it's being hovered over
var base_color = Color(1, 1, 1)  # The button's base color
var bg_sprite = null  # The background sprite node

func _ready():
	set_process_input(true)  # Enable input processing
	base_color = self.modulate  # Store the button's base color
	bg_sprite = get_parent().get_node("BackgroundSprite")  # Find the background sprite node
	resize_button()  # Call the resize function to set the initial button size

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

func _process(delta):
	resize_button()  # Call the resize function every frame to update the button size and position

func resize_button():
	# Calculate the button size and position relative to the background sprite and the screen resolution
	var button_size_ratio = Vector2(0.7, 0.3)  # The size of the button as a ratio of the screen resolution
	var screen_size = get_viewport_rect().size
	var button_size = screen_size * button_size_ratio
	var sprite_size = bg_sprite.get_texture().get_size() * bg_sprite.get_scale()
	var button_offset_ratio = Vector2(0.1, 0.1)  # The offset of the button position as a ratio of the screen resolution
	var button_offset = sprite_size * button_offset_ratio
	var button_position = bg_sprite.get_position() + button_offset
	button_position += (screen_size - sprite_size) / 2  # Center the button on the screen if the sprite doesn't fill the whole screen
	set_size(button_size)
	set_position(button_position)
