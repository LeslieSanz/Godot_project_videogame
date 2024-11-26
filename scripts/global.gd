extends Node

var puntos = 0
var vidas = 5
var titulo = "CronoLibertador"
var boton = "EMPEZAR A JUGAR"

func _ready():
	# Llama a la función para verificar las vidas cada frame.
	set_process(true)

func _process(delta):
	verificar_vidas()

func verificar_vidas():
	if vidas <= 0:
		titulo = "GAME OVER"
		boton = "VOLVER A JUGAR"
