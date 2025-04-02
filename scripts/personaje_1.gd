extends CharacterBody2D

const velocidad = 200

@onready var _arm : Node2D = $Arm
@onready var _weapon : Sprite2D = $Arm/Weapon

var enemy_in_range = false
var cooldown = true
var health = 10
var alive = true

var direccion = "no"

func jugador():
	pass

func _process(delta):
	player_movement(delta)
	ataque_enemigo()
	if health <= 0:
		alive = false
		health = 0
		print("has muerto bobo")
		self.queue_free()

func set_antorcha(direction: String):
	var directions = ["right", "left", "north", "south"]
	for dir in directions:
		var antorcha = $Personaje1.get_node_or_null("antorcha_" + dir)
		if antorcha:
			antorcha.visible = (dir == direction)
func antorcha_derecha():
	set_antorcha("right")
func antorcha_izquierda():
	set_antorcha("left")
func antorcha_norte():
	set_antorcha("north")
func antorcha_sur():
	set_antorcha("south")

func set_palo(direction: String):
	var directions = ["right", "left", "north", "south"]
	for dir in directions:
		var palo = $Personaje1.get_node_or_null("palo_" + dir)
		if palo:
			palo.visible = (dir == direction)

func palo_derecha():
	set_palo("right")
func palo_izquierda():
	set_palo("left")
func palo_norte():
	set_palo("north")
func palo_sur():
	set_palo("south")

func player_movement(delta):
	if Input.is_action_pressed("right"):
		direccion = "right"
		play_anim(1)
		velocity.x = velocidad
		velocity.y = 0
		antorcha_derecha()
		palo_derecha()
	elif Input.is_action_pressed("left"):
		direccion = "left"
		play_anim(1)
		velocity.x = -velocidad
		velocity.y = 0
		antorcha_izquierda()
		palo_izquierda()
	elif Input.is_action_pressed("down"):
		direccion = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = velocidad
		antorcha_sur()
		palo_sur()
	elif Input.is_action_pressed("up"):
		direccion = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -velocidad
		antorcha_norte()
		palo_norte()
	else:
		velocity.x = 0
		velocity.y = 0
		play_anim(0)
	
	move_and_slide()
	
	#ayuda

func play_anim(movement):
	var direccion_actual = direccion
	var anim = $Personaje1

	if direccion == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("right")
		elif movement == 0:
			anim.play("right_idle")

	if direccion == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("left")
		elif movement == 0:
			anim.play("left_idle")

	if direccion == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("south")
		elif movement == 0:
			anim.play("south_idle")

	if direccion == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("north")
		elif movement == 0:
			anim.play("north_idle")

func _on_hitbox_body_entered(body: Node2D):
	if body.has_method("enemigoreal"):
		enemy_in_range = true

func _on_hitbox_body_exited(body: Node2D):
	if body.has_method("enemigoreal"):
		enemy_in_range = false
		
func ataque_enemigo():
	if enemy_in_range and cooldown == true:
		health = health - 2
		cooldown = false
		$cooldown.start()
		print(health)

func _on_cooldown_timeout():
	cooldown = true
	
#que palo
#minuto video = 17:30
#continua en clase bobo
