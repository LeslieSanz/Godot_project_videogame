extends Control

var dialog = [
	'Ahora estoy en 1820, en la costa del Perú. La brisa del mar trae consigo no solo el aroma del océano, sino también la esperanza de libertad. Es aquí donde José de San Martín ha llegado con la Expedición Libertadora, decidido a terminar con el dominio colonial español.',
	'San Martín y sus tropas enfrentan un desafío titánico: tomar posiciones estratégicas y preparar el terreno para la proclamación de la independencia. Pero los realistas no cederán sin luchar; harán todo lo posible por retomar el control.',
	'No hay tiempo que perder. Debo unirme a los patriotas y asegurar que sus esfuerzos no sean en vano. Cada batalla ganada nos acerca un paso más a la libertad. ¡Es hora de luchar con valentía!'
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
var change_scene = preload("res://scenes/startLevel3.tscn")

func _ready():
	$descripcion.text = ''
	$TextureRect2.texture = null
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
