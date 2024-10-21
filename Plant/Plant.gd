extends Sprite2D

var newDeltaX
var newDeltaY
var deltaX
var deltaY
var touchPos = Vector2()
var areaEnt = false

# Referencia al Panel de información y RichTextLabel
@onready var info_panel = $Panel
@onready var info_richtext = $Panel/RichTextLabel

# Rutas de las imágenes de las etapas de crecimiento
var growth_stages = ["res://assets/Plant/baby.png", "res://assets/Plant/middle.png", "res://assets/Plant/madure.png"]
var current_stage = 0  # Índice de la etapa actual (0: baby, 1: middle, 2: mature)


func _on_touch_screen_button_pressed() -> void:
	areaEnt = true # Replace with function body.

func _on_touch_screen_button_released() -> void:
	areaEnt = false # Replace with function body.
# Temporizador para el crecimiento
@onready var growth_timer = Timer.new()

func _ready() -> void:
	info_panel.visible = false  # Ocultar el panel de información al inicio

	# Configurar el temporizador de crecimiento
	growth_timer.wait_time = 5  # Cambiar de etapa cada 5 segundos (puedes ajustar el tiempo)
	growth_timer.one_shot = false  # El temporizador se repite
	growth_timer.connect("timeout", Callable(self, "_on_growth_timer_timeout"))  # Corrección en Godot 4
	add_child(growth_timer)
	growth_timer.start()  # Iniciar el temporizador

	# Inicializar la imagen de la planta con la primera etapa
	update_plant_image()

# Función para actualizar la imagen de la planta
func update_plant_image() -> void:
	if current_stage < growth_stages.size():
		var plant_texture = load(growth_stages[current_stage]) as Texture2D
		texture = plant_texture  # Cambia la textura del Sprite2D

# Función que se llama cuando el temporizador alcanza el tiempo límite
func _on_growth_timer_timeout() -> void:
	current_stage += 1  # Pasar a la siguiente etapa de crecimiento
	if current_stage >= growth_stages.size():
		growth_timer.stop()  # Detener el temporizador si alcanzamos la etapa final
	else:
		update_plant_image()  # Actualizar la imagen de la planta a la nueva etapa

# Detecta el movimiento de la planta (tu código original)
func _input(event):
	if areaEnt == true:
		if event is InputEventScreenTouch and event.is_pressed():
			touchPos = event.get_position()
			deltaX = touchPos.x - position.x
			deltaY = touchPos.y - position.y

		elif event is InputEventScreenDrag:
			touchPos = event.get_position()
			newDeltaX = touchPos.x - deltaX
			newDeltaY = touchPos.y - deltaY
			set_position(Vector2(newDeltaX, newDeltaY))

# Mostrar/ocultar el panel de información
func _on_button_pressed() -> void:
	toggle_info_panel()

func toggle_info_panel() -> void:
	info_panel.visible = !info_panel.visible
	if info_panel.visible:
		info_richtext.text = "Type: Succulent\nName: Echeveria\n\nWatering: When the ground is completely dry, it is preferable that it goes thirsty than to drown it.\n\nIllumination: It needs a lot of luminosity and appreciates some direct sun, if we have it in pot inside the house, we will have to look for a space with a good dose of daily light.\n\nData: They are herbaceous, succulent, perennial, acaulescent plants or with simple or branched stems. The leaves are flattened and fleshy, arranged in the form of a rosette. They are green or brown, often with reddish apex and margin."
