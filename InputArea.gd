extends TextureRect

# We'll give input to the first renderer
# Then the CA (Cellular Automata) will ping-pong
# back and forth between the two viewports
onready var Renderer = $"/root/GameOfLife/Viewport/Renderer"

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

		Renderer.material.set_shader_param("mouse_position", pos)
