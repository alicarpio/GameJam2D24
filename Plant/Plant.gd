extends Sprite2D  # Asegúrate de que el script está en el nodo Sprite2D de la planta

var newDeltaX
var newDeltaY
var deltaX
var deltaY
var touchPos = Vector2()
var areaEnt = false

# Referencia al Panel de información y RichTextLabel
@onready var info_panel = $Panel  # Asegúrate de que la ruta sea correcta
@onready var info_richtext = $Panel/RichTextLabel  # El nodo RichTextLabel dentro del Panel

func _on_touch_screen_button_pressed() -> void:
	areaEnt = true # Replace with function body.

func _on_touch_screen_button_released() -> void:
	areaEnt = false # Replace with function body.

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

	

func _on_button_pressed() -> void:
	toggle_info_panel() # Replace with function body.
# Función para mostrar/ocultar el panel de información

func toggle_info_panel():
	info_panel.visible = !info_panel.visible  # Alterna visibilidad del panel
	if info_panel.visible:
		info_richtext.text = "Type: Succulent
Name: Echeveria

Watering: When the ground is completely dry, it is preferable that it goes thirsty than to drown it.

Illumination: It needs a lot of luminosity and appreciates some direct sun, if we have it in pot inside the house, we will have to look for a space with a good dose of daily light.

Data: They are herbaceous, succulent, perennial, acaulescent plants or with simple or branched stems. The leaves are flattened and fleshy, arranged in the form of a rosette. They are green or brown, often with reddish apex and margin."  # Texto de ejemplo # Asigna el texto de información de la planta
