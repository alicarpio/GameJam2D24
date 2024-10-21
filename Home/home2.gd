extends Node
# Referencia al nodo Plant
@onready var plant = $Bakground/Plant
  # Asegúrate de que la ruta sea correcta dentro de Home

func _ready():
	# Ocultar el nodo Plant al inicio
	plant.visible = false  


func _on_button_pressed() -> void:
	plant.visible = not plant.visible

	# Mensaje para depuración
	if plant.visible:
		print("Plant es visible")
	else:
		print("Plant está oculto")
	pass # Replace with function body.
