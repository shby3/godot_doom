extends Node3D

signal interacted

@onready var interactable: Area3D = $Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _interact

func _interact() -> void:
	if interactable.is_interactable:
		interacted.emit()
