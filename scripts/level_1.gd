extends Node2D

var pre_enemyShip = preload("res://scenes/enemyShip.tscn")
var pre_asteroid = preload("res://scenes/asteroid.tscn")


func _on_Timer_timeout():
	
	randomize()
	var randomEnemy = round(rand_range(1,2))
	
	if randomEnemy == 1:
		var enemyShip = pre_enemyShip.instance()
		self.call_deferred("add_child",enemyShip)
		enemyShip.position.y = round(rand_range(0,500))
		enemyShip.add_to_group("enemyShip")
		
	if randomEnemy == 2:
		var asteroid = pre_asteroid.instance()
		self.call_deferred("add_child",asteroid)
		asteroid.position.y = round(rand_range(0,500))
		asteroid.add_to_group("asteroid")

func _physics_process(delta):
	$hud/vidasValor.text = str(Global.vidas)
	$hud/puntosValor.text = str(Global.puntos)
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= 5
	
func _ready():
	$music/level_1_music.play()
