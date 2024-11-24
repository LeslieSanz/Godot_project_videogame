extends KinematicBody2D

func _physics_process(delta):
	position.x += 10


func _on_Area2D_area_entered(area):
	if area.is_in_group(("enemy")):
		queue_free()
