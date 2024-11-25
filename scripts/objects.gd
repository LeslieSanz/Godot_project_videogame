extends Node2D

# Precarga de la escena de la bala
var pre_bullet = preload("res://scenes/LEVEL2Enemy/bulletEnemy.tscn")

var shooting_speed = 0.5  # Velocidad de disparo (menor valor, más rápido)

func _ready():
	pass  # No necesitamos el temporizador

func _physics_process(_delta):
	# Disparar la bala cada cierto tiempo
	if _delta > shooting_speed:
		var bullet = pre_bullet.instance()
		# Asegúrate de que el nodo padre sea el correcto
		get_parent().add_child(bullet)
		bullet.position = position
		bullet.set_direction(Vector2(-1, 0))  # Dirección izquierda
		print("Bala disparada")  # Imprime un mensaje para verificar si se dispara

func _on_Area2D_area_entered(area):
	# Verificar si la bala del jugador golpea al enemigo
	if area.is_in_group("bullet"):
		Global.puntos += 5
		queue_free()
