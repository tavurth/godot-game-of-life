extends ColorRect

func _ready():
	pass

func _input(event: InputEvent):
	if not event is InputEventMouse:
		return

	if event is InputEventMouseButton:
		self.material.set_shader_param("mouse_pressed", event.pressed)

	if event is InputEventMouseMotion:
		var pos = event.position

		# Since we're using a control the Y-axis is inverted
		# Here we'll flip it back to how it should be
		pos.y = get_viewport_rect().size.y - pos.y

		self.material.set_shader_param("mouse_position", pos)
