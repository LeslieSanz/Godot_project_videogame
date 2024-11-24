extends Control

var dialog = [
	'¡Es increíble estar aquí! Todo este laboratorio es como algo sacado de un sueño… y esta nave… no puedo creer que realmente pueda viajar en el tiempo.',
	'Los científicos me dijeron que mi misión es crucial: debo usar esta nave para regresar al pasado y presenciar los momentos más importantes de la independencia del Perú. Pero no será solo observar… para volver a mi tiempo, debo completar tres misiones clave y asegurar que la historia siga su curso.',
	'Es un desafío enorme, pero también la aventura de mi vida. ¡Es hora de activar esta nave y cambiar la historia desde adentro!'
]

var dialog_index = 0
var finished = false
var text_speed = 0.01

func _ready():
	$descripcion.text = ''
	load_dialog()

func _process(delta):
	$next.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$descripcion.text = dialog[dialog_index]
		$descripcion.percent_visible = 0
		var tween_duration = text_speed * dialog[dialog_index].length()
		$Tween.interpolate_property(
			$descripcion, "percent_visible", 0,1,tween_duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dialog_index+=1


func _on_Tween_tween_completed(object, key):
	finished = true
