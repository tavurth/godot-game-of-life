extends TextureRect

onready var Renderer = $"../GameOfLife/Renderer"

func _ready():
	pass

func _input(event: InputEvent):
	if not event is InputEventMouse:
		return

	if not Renderer:
		print("Could not mount renderer")
		return

	if event is InputEventMouseButton:
		Renderer.material.set_shader_param("mouse_pressed", event.pressed)

	if event is InputEventMouseMotion:
		var pos = event.position

		# Flip mouse Y-Axis
		pos.y = get_viewport_rect().size.y - pos.y

		# We're using a double viewport, correct the mouse offset caused by this
		pos = pos / 2 + get_viewport_rect().size / 2;

		Renderer.material.set_shader_param("mouse_position", pos)
