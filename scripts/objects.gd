extends Node2D

func _ready():
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		Global.puntos += 5
		# Notificar al nodo principal que un enemigo fue derrotado
		get_parent().call_deferred("enemy_defeated")
		queue_free()
		
