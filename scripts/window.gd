extends Node3D

@onready var interactable: Area3D = $Interactable

signal interacted()

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact() -> void:
	if interactable.is_interactable:
		emit_signal("interacted")
		print("use window")
