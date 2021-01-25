extends TextureRect

onready var Renderer = $"../Viewport/Renderer"

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
