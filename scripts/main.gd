extends Control

func _ready():
	$titulo.text = Global.titulo
	
func _process(delta):
	# Verificar si el título cambia dinámicamente y actualizar el Label
	$titulo.text = Global.titulo
	$Button/Label.text = Global.boton

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/start.tscn")

func _on_Button2_pressed():
	# Finalizar el juego
	get_tree().quit()
