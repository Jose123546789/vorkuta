extends Node2D

func _process(delta):
	if Input.is_action_pressed("atacar"):
		atacar()

func atacar():
	$animacion_arma.play("palo")
	await $animacion_arma.animation_finished 
	$animacion_arma.play("palo_reset")

func palo():
	pass
