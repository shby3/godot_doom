extends Area3D

@onready var interactable: Area3D = $Interactable

signal interacted(target_position: Vector3)
signal interaction_ended

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact() -> void:
	if interactable.is_interactable:
		interactable.is_interactable = false
		emit_signal("interacted", global_position)
		print("sit down son")
	else:
		interactable.is_interactable = true
		emit_signal("interaction_ended")
		print("sit up son")
