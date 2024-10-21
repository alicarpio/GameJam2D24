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
		info_richtext.text = "Tipo: Flor
Riego: Semanal
Info : lalalala
"  # Texto de ejemplo # Asigna el texto de información de la planta
