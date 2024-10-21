extends TextureButton	

@onready var popup_menu = $PopupMenu  # Reference to PopupMenu

# Se llama cuando el nodo entra en la escena por primera vez
func _ready() -> void:
	connect("pressed", Callable(self, "_on_Inventario_pressed"))  # Callable corregido
	popup_menu.connect("id_pressed", Callable(self, "_on_Plant_Selected"))  # Callable corregido

# Función que se ejecuta cuando se presiona el botón de inventario
func _on_Inventario_pressed() -> void:
	popup_menu.popup()

# Función que maneja la selección del PopupMenu
func _on_Plant_Selected(id: int) -> void:
	match id:
		0:  # Suculenta
			print("Seleccionaste Suculenta")
		1:  # Aloe Vera
			print("Seleccionaste Aloe Vera")
