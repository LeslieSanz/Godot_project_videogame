extends Node2D

# Variables para las balas y el movimiento
var bullet = preload("res://scenes/LEVEL2Enemy/bulletEnemy.tscn")  # Carga el recurso de la bala
export (int) var enemy_speed = 40  # Velocidad de movimiento del enemigo

# Referencias a nodos
onready var timer = $Timer  # Nodo Timer para controlar el disparo
onready var shoot_position = $sprite/Position2D  # Nodo Position2D para la posición inicial del disparo

func _ready():
	# Iniciar el Timer, ya no lo detenemos después del primer disparo
	timer.start()  # Inicia el Timer para disparar repetidamente

func _physics_process(delta):
	position.x -= enemy_speed * delta  # Movimiento hacia la izquierda

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):  # Detectar colisión con balas del jugador
		Global.puntos += 5
		# Notificar al nodo principal que un enemigo fue derrotado
		get_parent().call_deferred("enemy_defeated")
		queue_free()

func _on_Timer_timeout():
	# Crear la bala y posicionarla
	var BalaInstance = bullet.instance()
	BalaInstance.global_position = shoot_position.global_position + Vector2(20, 0)  # Ajusta el desplazamiento inicial
	add_child(BalaInstance)  # Añade la bala como hija del enemigo para que se mueva con él
	
	# Reiniciar el Timer después de disparar
	timer.start()  # Reinicia el temporizador para que dispare nuevamente
