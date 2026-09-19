extends PanelContainer

@onready var cursor = $Cursor

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor.position = event.position
	
func _on_border_mouse_entered() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_screen_contents_mouse_entered() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
