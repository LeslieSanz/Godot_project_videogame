extends KinematicBody2D  # Mantén el tipo KinematicBody2D para la bala

export (int) var speed = 600

func _physics_process(delta):
	position.x -= speed * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()

func _on_Area2D_area_entered(area):
	pass # Replace with function body.
