extends Node2D

var pre_enemyShip = preload("res://scenes/LEVEL2Enemy/Enemy2.tscn")
var pre_asteroid = preload("res://scenes/LEVEL2Enemy/Enemy1.tscn")

var total_enemies = 10  # Número total de enemigos
var enemies_spawned = 0  # Enemigos generados
var enemies_defeated = 0  # Enemigos derrotados
var dialog_index = 0

# Escena de derrota
var defeat_scene = preload("res://scenes/main.tscn")  

#variable de cambio de escena
var change_scene = preload("res://scenes/startLevel3.tscn")  

var images_vida = [
	preload("res://assets/ui/VIDA0.png"),  
	preload("res://assets/ui/VIDA1.png"),  
	preload("res://assets/ui/VIDA2.png"),  
	preload("res://assets/ui/VIDA3.png"),  
	preload("res://assets/ui/VIDA4.png"),  
	preload("res://assets/ui/VIDA5.png")    
]

var next_scene = null

#genera enemigos
func _on_Timer_timeout():
	if enemies_spawned < total_enemies:
		randomize()
		var randomEnemy = round(rand_range(1,2))
		
		if randomEnemy == 1:
			var enemyShip = pre_enemyShip.instance()
			self.call_deferred("add_child",enemyShip)
			enemyShip.position.y = round(rand_range(0,230))
			enemyShip.add_to_group("enemy")
		elif randomEnemy == 2:
			var asteroid = pre_asteroid.instance()
			self.call_deferred("add_child",asteroid)
			asteroid.position.y = round(rand_range(0,230))
			asteroid.add_to_group("enemy")
		
		enemies_spawned += 1 
	else:
		# Detener el temporizador cuando se hayan generado todos los enemigos
		$Timer.stop()

func _physics_process(delta):
	$hud/vidasValor.text = str(Global.vidas)
	$hud/puntosValor.text = str(Global.puntos)
	# Cambiar imagen
	$hud/tablerito2.texture = images_vida[Global.vidas]
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= 5
	
	# Verifica si el jugador ha derrotado a todos los enemigos
	if enemies_defeated >= total_enemies and Global.vidas > 0:
		show_message("¡Victoria! Has derrotado a todos los enemigos.", "win_game")
		
	# Verifica si el jugador ha perdido todas las vidas
	if Global.vidas <= 0:
		show_message("¡Derrota! No quedan vidas.", "lose_game")

	
func _ready():
	$music/level_1_music.play()
	$hud/tablerito2.texture = null
	$music/level_1_music.seek(10)
	print("Enemigos derrotados: ", enemies_defeated)


func win_game():
	# Cambiar a la escena de victoria
	if not $hud/Timer2.is_stopped():
		return  # No reiniciar el temporizador si ya está corriendo
	
	next_scene = change_scene
	print("Iniciando Timer2 para pasar nivel3")
	$hud/Timer2.start()
	
func lose_game():
	# Cambiar a la escena de derrota
	if not $hud/Timer2.is_stopped():
		return  # No reiniciar el temporizador si ya está corriendo
	
	next_scene = defeat_scene
	print("Iniciando Timer2 para derrota")
	$hud/Timer2.start()

# Mostrar un mensaje y ejecutar una función después
func show_message(text, action):
	$hud/Label.text = text
	$hud/Label.visible = true
	$hud/Label.modulate = Color(1, 1, 1, 1)  # Mostrarlo con opacidad completa
	call_deferred(action)
	
# Llamar a esta función cuando un enemigo sea derrotado
func enemy_defeated():
	enemies_defeated += 1


# Función para manejar el temporizador Timer2
func _on_Timer2_timeout():
	if next_scene != null:
		get_tree().change_scene_to(next_scene)
	else:
		print("Error: next_scene es null.")
