extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 200
var readyToShoot = true		

var pre_bullet = preload("res://scenes/bullet.tscn")

func _physics_process(delta):
	# Movimiento hacia abajo (tecla ↓)
	if Input.is_action_pressed("ui_down"):  # "ui_down" es la tecla de flecha hacia abajo
		velocity.y = SPEED
		
	# Movimiento hacia arriba (tecla ↑)
	elif Input.is_action_pressed("ui_up"):  # "ui_up" es la tecla de flecha hacia arriba
		velocity.y = -SPEED
		
	# Movimiento hacia la derecha (tecla →)
	elif Input.is_action_pressed("ui_right"):  # "ui_right" es la tecla de flecha hacia la derecha
		velocity.x = SPEED
		
	# Movimiento hacia la izquierda (tecla ←)
	elif Input.is_action_pressed("ui_left"):  # "ui_left" es la tecla de flecha hacia la izquierda
		velocity.x = -SPEED
		
	# Detener movimiento si no se presiona ninguna tecla
	else:
		velocity.x = 0
		velocity.y = 0
		
	# Disparo (tecla espacio)
	if Input.is_action_just_pressed("ui_accept"):  # "ui_accept" es la tecla de espacio
		shoot()
		
	# Movimiento y deslizamiento
	move_and_slide(velocity)
	
func shoot():
	if readyToShoot:
		# Instanciar la bala
		var bullet = pre_bullet.instance()
		get_parent().add_child(bullet)  # Agregar al nodo padre
		
		# Establecer posición inicial de la bala
		bullet.position = position
		
		# Bloquear disparo temporalmente
		readyToShoot = false
		
		# Reanudar disparo después de 1 segundo
		yield(get_tree().create_timer(1), "timeout")
		readyToShoot = true


func _on_Area2D_area_entered(area):
	if area.is_in_group("asteroid"):
		print("asteroid crash")
		
	elif area.is_in_group("enemyShip"):
		print("enemyShip crash")
