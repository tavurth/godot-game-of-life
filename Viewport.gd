extends Viewport


func _ready():
	# We've turned off the viewport rendering in the
	# Godot editor to improve battery life & development time
	#
	# Here we enable it again when we load the viewport in game
	self.set_update_mode(UPDATE_ALWAYS)
