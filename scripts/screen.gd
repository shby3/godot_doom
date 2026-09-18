extends PanelContainer

@onready var cursor = $Cursor

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor.position = event.position

func _on_mouse_entered() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _on_border_mouse_entered() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
