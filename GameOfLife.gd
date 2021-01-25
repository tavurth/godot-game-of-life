extends Control


func _ready():
	# We've turned off the viewport rendering in the
	# Godot editor to improve battery life & development time
	#
	# Here we enable it again when we load the viewport in game
	$Viewport.set_update_mode(Viewport.UPDATE_ALWAYS)
	$Viewport2.set_update_mode(Viewport.UPDATE_ALWAYS)
