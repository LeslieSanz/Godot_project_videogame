extends Control

var dialog = [
	'Esto es Ayacucho, 1824… Aquí, en estas montañas, se librará la batalla más importante para el futuro de Perú y toda Sudamérica.',
	'Simón Bolívar y su ejército libertador están enfrentando las últimas fuerzas del dominio colonial español. Su victoria marcará el fin de siglos de opresión y abrirá el camino hacia la libertad para millones de personas.',
	'Pero no será fácil. Los realistas están bien armados y decididos a mantener su poder. Si perdemos aquí, perderemos mucho más que una batalla: perderemos el sueño de la independencia. Es mi momento de actuar. Si quiero regresar a mi época, debo ayudar a Bolívar y a sus hombres a conseguir esta victoria crucial.'
]

var dialog_images = [
	preload("res://assets/sprites/personaje1.png"),  # Imagen para el primer diálogo
	preload("res://assets/sprites/personaje2.png"),  # Imagen para el segundo diálogo
	preload("res://assets/sprites/personaje3.png")   # Imagen para el tercer diálogo
]

var dialog_index = 0
var finished = false
var iniciobutton = false
var text_speed = 0.01

#variable de cambio de escena
var change_scene = preload("res://scenes/level_3.tscn")

func _ready():
	$descripcion.text = ''
	$TextureRect2.texture = null
	$Node2D/AudioStreamPlayer.seek(10)
	load_dialog()

func _process(delta):
	$next.visible = finished
	$Button.visible = iniciobutton
	
	# Cambiar de escena si es el tercer diálogo y se presiona Enter
	if dialog_index == 3 and Input.is_action_just_pressed("ui_accept"):
		_on_Button_pressed()
	
	# Continuar con el flujo normal si no es el tercer diálogo
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		iniciobutton = false
		# Cambiar texto
		$descripcion.text = dialog[dialog_index]
		$descripcion.percent_visible = 0
		
		# Cambiar imagen
		$TextureRect2.texture = dialog_images[dialog_index]
		
		# Configurar el tween para mostrar el texto progresivamente
		var tween_duration = text_speed * dialog[dialog_index].length()
		$Tween.interpolate_property(
			$descripcion, "percent_visible", 0,1,tween_duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		
		# Si es el tercer diálogo (índice 2), muestra el botón
		if dialog_index == 2:
			iniciobutton = true
	else:
		queue_free()
	dialog_index+=1



#cambio de scena
func _on_Button_pressed():
	get_tree().change_scene_to(change_scene)
	pass # Replace with function body.


func _on_Tween_tween_completed(object, key):
	# Si es el tercer diálogo, mantenemos finished como false
	if dialog_index == 3:
		finished = false
	else:
		finished = true
