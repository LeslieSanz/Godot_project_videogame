extends Node2D

var pre_enemyShip = preload("res://scenes/enemyShip.tscn")
var pre_asteroid = preload("res://scenes/asteroid.tscn")
func _ready():
	pass 

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
