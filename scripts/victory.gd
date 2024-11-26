extends Control

var dialog = [
	'Lo logramos… Perú es libre, y con esta victoria, comienza un nuevo capítulo para toda Sudamérica. Pero esta independencia no fue fácil. Cada batalla, cada sacrificio, cada vida entregada dejó una marca imborrable en la historia.',
	'Mirando todo esto, entiendo que la historia no es solo un registro del pasado, sino una lección para el futuro. Es un recordatorio de que, incluso en los momentos más oscuros, hay quienes se levantan para luchar por lo que es justo.',
	'Ahora, regreso a mi tiempo, pero llevo conmigo todo lo que viví aquí. Los ideales de estos héroes no son cosa del pasado; son el cimiento de lo que somos y de lo que podemos llegar a ser.'
]

var dialog_images = [
	preload("res://assets/sprites/personaje1.png"),
	preload("res://assets/sprites/personaje2.png"),
	preload("res://assets/sprites/personaje3.png")
]

var dialog_index = 0
var finished = false
var iniciobutton = false
var text_speed = 0.01


func _ready():
	# Configurar la descripción e imagen inicial
	$descripcion.text = ''
	$TextureRect2.texture = null
	$Node2D/AudioStreamPlayer.seek(3)
	load_dialog()  # Iniciar el diálogo


func _process(delta):
	$next.visible = finished
	$Button.visible = iniciobutton

	# Detectar entrada para avanzar el diálogo solo si hay más diálogos
	if Input.is_action_just_pressed("ui_accept") and dialog_index < dialog.size():
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		iniciobutton = false

		# Configurar texto e imagen para el diálogo actual
		$descripcion.text = dialog[dialog_index]
		$descripcion.percent_visible = 0
		$TextureRect2.texture = dialog_images[dialog_index]

		# Configurar animación del texto
		var tween_duration = text_speed * dialog[dialog_index].length()
		$Tween.interpolate_property(
			$descripcion, "percent_visible", 0, 1, tween_duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()

		# Mostrar el botón solo en el último diálogo
		if dialog_index == 2:
			iniciobutton = true
	else:
		queue_free()  # Si se acaba el diálogo, cerrar el nodo actual

	dialog_index += 1



func _on_Button_pressed():
	# Finalizar el juego
	get_tree().quit()


func _on_Tween_tween_completed(object, key):
	# Si es el tercer diálogo, mantenemos finished como false
	if dialog_index == 3:
		finished = false
	else:
		finished = true
