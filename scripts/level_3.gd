extends Node2D

var pre_enemyArmy = preload("res://scenes/enemies/soldier.tscn")
var pre_canyon = preload("res://scenes/enemies/canyon.tscn")

#genera enemigos
func _on_Timer_timeout():
	randomize()
	var randomEnemy = round(rand_range(1,2))
	
	if randomEnemy == 1:
		var enemyArmy = pre_enemyArmy.instance()
		self.call_deferred("add_child",enemyArmy)
		enemyArmy.position.y = round(rand_range(0,400))
		enemyArmy.add_to_group("enemyArmy")
		
	if randomEnemy == 2:
		var canyon = pre_canyon.instance()
		self.call_deferred("add_child",canyon)
		canyon.position.y = round(rand_range(0,450))
		canyon.add_to_group("canyon")

func _physics_process(delta):
	$hud/vidasValor.text = str(Global.vidas)
	$hud/puntosValor.text = str(Global.puntos)
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= 5
	
func _ready():
	$music/level_2_music.play()
