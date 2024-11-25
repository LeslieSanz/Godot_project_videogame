extends Node2D

var pre_enemyArmy = preload("res://scenes/enemies/soldier.tscn")
var pre_canyon = preload("res://scenes/enemies/canyon.tscn")

var total_enemies = 5  # Número total de enemigos
var enemies_spawned = 0  # Enemigos generados
var enemies_defeated = 0  # Enemigos derrotados

# Escena de victoria y derrota
var victory_scene = preload("res://scenes/startLevel3.tscn")
var defeat_scene = preload("res://scenes/start.tscn")  


#genera enemigos
func _on_Timer_timeout():
	if enemies_spawned < total_enemies:
		randomize()
		var randomEnemy = round(rand_range(1, 2))
		
		if randomEnemy == 1:
			var enemyArmy = pre_enemyArmy.instance()
			self.call_deferred("add_child", enemyArmy)
			enemyArmy.position.y = round(rand_range(0, 280))
			enemyArmy.add_to_group("enemyArmy")
		elif randomEnemy == 2:
			var canyon = pre_canyon.instance()
			self.call_deferred("add_child", canyon)
			canyon.position.y = round(rand_range(0, 280))
			canyon.add_to_group("canyon")
		
		enemies_spawned += 1  # Incrementa el contador de enemigos generados
	else:
		# Detener el temporizador cuando se hayan generado todos los enemigos
		$Timer.stop()

func _physics_process(delta):
	$hud/vidasValor.text = str(Global.vidas)
	$hud/puntosValor.text = str(Global.puntos)
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= 5
	
	# Verifica si el jugador ha derrotado a todos los enemigos
	if enemies_defeated >= total_enemies and Global.vidas > 0:
		win_game()
	
	# Verifica si el jugador ha perdido todas las vidas
	if Global.vidas <= 0:
		lose_game()
	
func _ready():
	$music/level_2_music.play()
	
func win_game():
	# Cambiar a la escena de victoria
	get_tree().change_scene_to(victory_scene)
	
func lose_game():
	# Cambiar a la escena de derrota
	get_tree().change_scene_to(defeat_scene)

# Llamar a esta función cuando un enemigo sea derrotado
func enemy_defeated():
	enemies_defeated += 1
