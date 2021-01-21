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

		self.material.set_shader_param("mouse_position", pos)
