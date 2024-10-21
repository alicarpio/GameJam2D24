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

# Referencias a las barras de progreso de agua y sol
@onready var water_bar = $ProgressBarWater  # Reemplaza la ruta si es necesario
@onready var sun_bar = $ProgressBarSun  # Reemplaza la ruta si es necesario

# Rutas de las imágenes de las etapas de crecimiento
var growth_stages = ["res://assets/Plant/baby.png", "res://assets/Plant/middle.png", "res://assets/Plant/madure.png"]
var current_stage = 0  # Índice de la etapa actual (0: baby, 1: middle, 2: mature)

# Temporizadores para el crecimiento y las barras de progreso
@onready var growth_timer = Timer.new()  # Temporizador para el crecimiento de la planta
@onready var bar_timer = Timer.new()  # Temporizador para el progreso de las barras

var water_filled = false  # Bandera para verificar si la barra de agua está llena
var sun_filled = false  # Bandera para verificar si la barra de sol está llena

func _on_touch_screen_button_pressed() -> void:
	areaEnt = true # Replace with function body.

func _on_touch_screen_button_released() -> void:
	areaEnt = false # Replace with function body.


func _ready() -> void:
	info_panel.visible = false  # Ocultar el panel de información al inicio

	# Configurar el temporizador de crecimiento
	growth_timer.wait_time = 10  # Tiempo total para cada etapa de crecimiento
	growth_timer.one_shot = false  # El temporizador se repite
	growth_timer.connect("timeout", Callable(self, "_on_growth_timer_timeout"))
	add_child(growth_timer)
	growth_timer.start()  # Iniciar el temporizador

	# Configurar el temporizador de las barras de progreso
	bar_timer.wait_time = 0.1  # Cada 0.1 segundos aumenta el progreso
	bar_timer.one_shot = false
	bar_timer.connect("timeout", Callable(self, "_on_bar_timer_timeout"))
	add_child(bar_timer)
	bar_timer.start()  # Iniciar el temporizador para las barras

	# Inicializar la imagen de la planta con la primera etapa
	update_plant_image()

	# Inicializar las barras
	reset_bars()

# Resetea las barras de progreso a 0
func reset_bars() -> void:
	water_bar.value = 0
	sun_bar.value = 0
	water_filled = false
	sun_filled = false

# Función para actualizar la imagen de la planta
func update_plant_image() -> void:
	if current_stage < growth_stages.size():
		var plant_texture = load(growth_stages[current_stage]) as Texture2D
		texture = plant_texture  # Cambia la textura del Sprite2D

# Función que se llama cuando el temporizador de crecimiento alcanza el tiempo límite
func _on_growth_timer_timeout() -> void:
	if water_filled and sun_filled:  # Solo cambiar de etapa si ambas barras están llenas
		current_stage += 1  # Pasar a la siguiente etapa de crecimiento
		if current_stage >= growth_stages.size():
			growth_timer.stop()  # Detener el temporizador si alcanzamos la etapa final
			bar_timer.stop()  # También detener el temporizador de las barras
		else:
			update_plant_image()  # Actualizar la imagen de la planta a la nueva etapa
			reset_bars()  # Reiniciar las barras para la siguiente etapa

# Temporizador para manejar el progreso de las barras de agua y sol
func _on_bar_timer_timeout() -> void:
	if not water_filled:
		water_bar.value += 2  # Aumenta el progreso de agua
		if water_bar.value >= water_bar.max_value:
			water_filled = true  # Marca la barra de agua como llena
	else:
		sun_bar.value += 2  # Si agua está llena, aumenta el progreso de sol
		if sun_bar.value >= sun_bar.max_value:
			sun_filled = true  # Marca la barra de sol como llena

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
