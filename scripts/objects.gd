extends Node2D

# Variables para las balas y el movimiento
var bullet = preload("res://scenes/LEVEL2Enemy/bulletEnemy.tscn")  # Carga el recurso de la bala
export (int) var enemy_speed = 40  # Velocidad de movimiento del enemigo

# Referencias a nodos
onready var timer = $Timer  # Nodo Timer para controlar el disparo
onready var shoot_position = $sprite/Position2D  # Nodo Position2D para la posición inicial del disparo

func _ready():
	# Iniciamos el temporizador, pero no lo detenemos después del primer disparo
	timer.start()

func _physics_process(delta):
	position.x -= enemy_speed * delta  # Movimiento hacia la izquierda

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		Global.puntos += 5
		# Notificar al nodo principal que un enemigo fue derrotado
		get_parent().call_deferred("enemy_defeated")
		queue_free()

func _on_Timer_timeout():
	# Crear la bala y posicionarla
	var BalaInstance = bullet.instance()
	BalaInstance.global_position = shoot_position.global_position  # Usa la posición del nodo Position2D
	get_parent().add_child(BalaInstance)  # Añade la bala al mismo nivel que el enemigo
	
	# Reinicia el temporizador para disparar nuevamente
	timer.start()  # Reinicia el temporizador para que dispare nuevamente
