extends Node3D

signal collected

@onready var interactable: Area3D = $Interactable

func _ready() -> void:
	interactable.interact = _collect

func _collect() -> void:
	emit_signal("collected")
	print("collected")
	queue_free()
