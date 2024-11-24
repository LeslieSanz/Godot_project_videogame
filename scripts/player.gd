extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 200
var readyToShoot = true		

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
		
	# Movimiento y deslizamiento
	move_and_slide(velocity)
