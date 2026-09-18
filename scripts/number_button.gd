extends Button

@onready var label: Label = $Label
var num_value: int = 0

signal value_changed

func _on_pressed() -> void:
	num_value = (num_value + 1) % 10
	label.text = str(num_value)
	value_changed.emit()
