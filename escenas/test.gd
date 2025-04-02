extends CharacterBody2D

var radius = 5

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var player_pos = get_global_position()  # Global position of $Jugador
	var mouse_dir = (mouse_pos - player_pos).normalized()

	# Convert $ayuda's position to global space
	var ayuda_offset = mouse_dir * radius
	var ayuda_global_pos = player_pos + ayuda_offset

	# Set the global position of $ayuda
	$ayuda.global_position = ayuda_global_pos
