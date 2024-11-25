extends Node2D

func _ready():
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		Global.puntos += 5
		queue_free()
		
