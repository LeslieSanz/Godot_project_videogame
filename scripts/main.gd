extends Control

func _ready():
	$Node2D/AudioStreamPlayer.seek(3)
	$titulo.text = Global.titulo
	
func _process(delta):
	# Verificar si el título cambia dinámicamente y actualizar el Label
	$titulo.text = Global.titulo
	$Button/Label.text = Global.boton

func _on_Button_pressed():
	# Reiniciar variables globales
	Global.vidas = 5
	Global.puntos = 0
	
	# Reiniciar título y botón
	Global.titulo = "CronoLibertador"
	Global.boton = "EMPEZAR A JUGAR"
	
	# Cambiar a la escena inicial
	get_tree().change_scene("res://scenes/start.tscn")

func _on_Button2_pressed():
	# Finalizar el juego
	get_tree().quit()
