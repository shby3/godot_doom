extends PanelContainer

@onready var cursor = $Cursor

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor.position = event.position
		
